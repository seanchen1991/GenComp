defmodule GenComp.Repo.Migrations.CreateCompetitor do
    use Ecto.Migration

    def change do
        create table(:competitors) do
            add :first_name, :string, null: false
            add :last_name, :string, null: false
            add :email, :string, null: false
            add :password_hash, :string

            timestamps
        end

        create unique_index(:competitors, [:email])
    end
end
