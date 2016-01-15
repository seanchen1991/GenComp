defmodule GenComp.Auth do
    import Plug.Conn

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
end
