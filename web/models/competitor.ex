defmodule GenComp.Competitor do
    use GenComp.Web, :model
    
    schema "competitors" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :password, :string, virtual: true
        field :password_hash, :string

        timestamps
    end
end
