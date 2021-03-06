defmodule GenComp.Router do
  use GenComp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GenComp.Auth, repo: GenComp.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GenComp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/competitors", CompetitorController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", GenComp do
  #   pipe_through :api
  # end
end
