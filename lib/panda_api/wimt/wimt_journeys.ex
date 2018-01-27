defmodule PandaApi.Wimt.Journeys do
	use GenServer

	alias PandaApi.Wimt
	alias PandaApi.WimtToken

	@name WIMTJ
	@maxItineraries 5


	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, :ok, opts ++ [name: WIMTJ])
	end

	def get_journey(origin, destination) do
		GenServer.call(@name, {:get_journey, { origin, destination }})
	end

	def handle_call({:get_journey, { origin, destination }}, _from, state) do
		IO.inspect journey_post_req(origin, destination)
		{ :reply, %{}, state }
	end

	def init(:ok) do
		{:ok, %{}}
	end

	defp journey_post_req(origin, destination) do
		Wimt.post! "/api/journeys", journey_post_params(origin, destination), [{"Authorization", "Bearer #{WimtToken.get_token["access_token"]}"}]
	end

	defp journey_post_params(origin, destination) do
		params = %{
			geometry: %{
				type: "Multipoint",
				coordinates: [origin, destination]
			},
			maxItineraries: @maxItineraries
		}

		Poison.encode! params
	end
end
