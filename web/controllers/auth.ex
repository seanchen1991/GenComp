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
end
