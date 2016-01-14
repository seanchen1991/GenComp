defmodule GenComp.CompetitorController do
    use GenComp.Web, :controller
    alias GenComp.Competitor

    def index(conn, _params) do
        competitors = Repo.all(GenComp.Competitor)
        render conn, "index.html", competitors: competitors
    end

    def show(conn, %{"id" => id}) do
        competitor = Repo.get(GenComp.Competitor, id)
        render conn, "show.html", competitor: competitor
    end

    def new(conn, _params) do
        changeset = Competitor.changeset(%Competitor{})
        render conn, "new.html", changeset: changeset
    end
end
