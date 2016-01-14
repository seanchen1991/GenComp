defmodule GenComp.Repo do
    @moduledoc """
    In-memory repository
    """

    def get(module, id) do
        Enum.find all(module), fn map -> map.id == id end
    end

    def get_by(module, params) do
        Enum.find all(module), fn map ->
            Enum.all?(params, fn {key, val} ->
                Map.get(map, key) == val
            end)
        end
    end

    def all(GenComp.Competitor) do
        [%GenComp.Competitor{
            id: "1", first_name: "Sean", last_name: "Chen", email: "seanchen11235@gmail.com", password: "123qweasd"
         }, %GenComp.Competitor{
             id: "2", first_name: "Mengsha", last_name: "Gong", email: "xdarkswanwaterx@gmail.com", password: "123qweasd"
         }, %GenComp.Competitor{
             id: "3", first_name: "Vincent", last_name: "Hayashi", email: "vincehayashi@gmail.com", password: "123qweasd"
         }]
    end
    def all(_module), do: []
end
