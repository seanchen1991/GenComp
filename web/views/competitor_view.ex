defmodule GenComp.CompetitorView do
    use GenComp.Web, :view
    alias GenComp.Competitor

    def first_name(%Competitor{first_name: first_name}) do
        first_name
        |> String.split(" ")
        |> Enum.at(0)
    end

    def last_name(%Competitor{last_name: last_name}) do
        last_name
        |> String.split(" ")
        |> Enum.at(0)
    end
end
