defmodule GenComp.CompetitorController do
    use GenComp.Web, :controller
    plug :authenticate when action in [:index, :show]
    alias GenComp.Competitor

    def index(conn, _params) do
        competitors = Repo.all(Competitor)
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
        changeset = Competitor.registration_changeset(%Competitor{}, competitor_params)
        case Repo.insert(changeset) do
            {:ok, competitor} ->
                conn
                |> GenComp.Auth.login(competitor)
                |> put_flash(:info, "#{competitor.first_name} #{competitor.last_name} has registered!")
                |> redirect(to: competitor_path(conn, :index))
            {:error, changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    defp authenticate(conn, _opts) do
        if conn.assigns.current_competitor do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in to access that page.")
            |> redirect(to: page_path(conn, :index))
            |> halt()
        end
    end
end
