defmodule PandaApiWeb.JourneyController do
	use PandaApiWeb, :controller

	def create(conn, %{ "origin" => origin, "destination" => destination }) do
		origin = format_coordinates(origin)
		destination = format_coordinates(destination)
		results = PandaApi.Wimt.Journeys.get_journey(origin, destination)
		itineraries = results["itineraries"]

		render conn, "index.json", results: itineraries
	end

	defp format_coordinates(coordinates) do
		Enum.map(coordinates, fn (c) ->
			to_float(c)
		end)
	end

	defp to_float(val) when not is_number(val) do
		{num, _} = Float.parse(val)
		num
	end
	defp to_float(val), do: val
end
