defmodule ItaWeb.Router do
  use ItaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    # plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ItaWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/contacts", PageController, :contacts

    get "/feedback", PageController, :feedback
    post "/feedback", PageController, :save_feedback

    get "/auto/:id", PageController, :auto
    get "/search", PageController, :search
  end

  # Other scopes may use custom stacks.
  scope "/api", ItaWeb do
    pipe_through :api

    get "/test", ApiController, :test
  end
end
