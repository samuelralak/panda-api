defmodule PandaApiWeb.SearchView do
	use PandaApiWeb, :view

	def render("index.json", %{ results: results, location: location }) do
		%{
			current_location: location,
			data: render_many(results, __MODULE__, "search.json")
		}
	end

	def render("search.json", %{ search: search }) do
		%{
			id: search["id"],
			name: search["name"],
			about: search["about"],
			description: search["description"],
			is_always_open: search["is_always_open"],
			is_permanently_closed: search["is_permanently_closed"],
			facebook_page_link: search["link"],
			phone: search["phone"],
			address: search["single_line_address"],
			location: %{
				latitude: search["location"]["latitude"],
				longitude: search["location"]["longitude"]
			},
			website: search["website"],
			picture: search["picture"]["data"]["url"]
		}
	end
end