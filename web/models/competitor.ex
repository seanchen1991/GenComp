defmodule GenComp.Competitor do
    use GenComp.Web, :model

    @required_params ~w(first_name last_name email)
    @optional_params ~w()

    schema "competitors" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :password, :string, virtual: true
        field :password_hash, :string

        timestamps
    end

    def changeset(model, params \\ :empty) do
        model
        |> cast(params, @required_params, @optional_params)
        |> unique_constraint(:email)
        |> validate_format(:email, ~r/@/)
    end
end
