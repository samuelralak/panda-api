defmodule PandaApiWeb.SearchController do
	use PandaApiWeb, :controller

	alias PandaApi.Facebook.Places

	def index(conn, %{ "latitude" => latitude, "longitude" => longitude }) do
		results = Places.search("#{latitude},#{longitude}", "10000")
		render conn, "index.json", results: results
	end
end