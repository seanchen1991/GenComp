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

    def create(conn, %{"competitor" => competitor_params}) do
        changeset = Competitor.changeset(%Competitor{}, competitor_params)
        case Repo.insert(changeset) do
            {:ok, competitor} ->
                conn
                |> put_flash(:info, "#{competitor.first_name} #{competitor.last_name} has registered!")
                |> redirect(to: competitor_path(conn, :index))
            {:error, changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end
end
