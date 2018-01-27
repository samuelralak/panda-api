defmodule PandaApiWeb.SearchController do
	use PandaApiWeb, :controller

	alias PandaApi.Facebook.Places

	def index(conn, %{ "latitude" => latitude, "longitude" => longitude }) do
		results = Places.search("#{latitude},#{longitude}", "10000")
		current_location = [longitude, latitude]
		render conn, "index.json", results: results, location: current_location
	end
end