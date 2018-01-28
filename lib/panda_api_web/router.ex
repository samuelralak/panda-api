defmodule PandaApiWeb.Router do
  use PandaApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PandaApiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", PandaApiWeb do
    pipe_through :api

    get "/search",  SearchController,  :index
    post "/journey", JourneyController, :create
  end
end
