defmodule GenComp.CompetitorController do
    use GenComp.Web, :controller

    def index(conn, _params) do
        competitors = Repo.all(GenComp.Competitor)
        render conn, "index.html", competitors: competitors
    end

    def show(conn, %{"id" => id}) do
        competitor = Repo.get(GenComp.Competitor, id)
        render conn, "show.html", competitor: competitor
    end
end
