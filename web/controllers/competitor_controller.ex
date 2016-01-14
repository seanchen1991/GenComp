defmodule GenComp.CompetitorController do
    use GenComp.Web, :controller

    def index(conn, _params) do
        competitors = Repo.all(GenComp.Competitor)
        render conn, "index.html", competitors: competitors
    end
end
