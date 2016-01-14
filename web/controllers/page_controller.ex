defmodule GenComp.PageController do
  use GenComp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
