defmodule PandaApiWeb.PageController do
  use PandaApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
