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
        |> validate_length(:first_name, min: 1)
        |> validate_length(:last_name, min: 1)
        |> unique_constraint(:email)
        |> validate_format(:email, ~r/@/)
    end

    def registration_changeset(model, params) do
        model
        |> changeset(params)
        |> cast(params, ~w(password), [])
        |> validate_length(:password, min: 6, max: 100)
        # |> validate_confirmation(:password, message: "Does not match password")
        |> put_pass_hash()
    end

    defp put_pass_hash(changeset) do
        case changeset do
            %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
                put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
            _ ->
                changeset
        end
    end
end
