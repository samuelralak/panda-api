defmodule PandaApiWeb.SearchView do
	use PandaApiWeb, :view

	def render("index.json", %{ results: results }) do
		render_many(results, __MODULE__, "search.json")
	end

	def render("search.json", %{ search: search }) do
		%{
			name: search["name"]
		}
	end
end