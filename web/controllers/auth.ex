defmodule GenComp.Auth do
    import Plug.Conn
    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    def init(opts) do
        Keyword.fetch!(opts, :repo)
    end

    def call(conn, repo) do
        competitor_id = get_session(conn, :competitor_id)
        competitor = competitor_id && repo.get(GenComp.Competitor, competitor_id)
        assign(conn, :current_competitor, competitor)
    end

    def login(conn, competitor) do
        conn
        |> assign(:current_competitor, competitor)
        |> put_session(:competitor_id, competitor.id)
        |> configure_session(renew: true)
    end

    def login_with_email_and_pass(conn, email, given_pass, opts) do
        repo = Keyword.fetch!(opts, :repo)
        competitor = repo.get_by(GenComp.Competitor, email: email)

        cond do
            competitor && checkpw(given_pass, competitor.password_hash) ->
                {:ok, login(conn, competitor)}
            competitor ->
                {:error, :unauthorized, conn}
            true ->
                dummy_checkpw()
                {:error, :not_found, conn}
        end
    end
end
