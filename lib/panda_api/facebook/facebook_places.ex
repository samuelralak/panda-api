defmodule PandaApi.Facebook.Places do
	use GenServer

	@name FBP
	@fields ~s(name,location,category_list)


	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, :ok, opts ++ [name: FBP])
	end

	def search(center, radius) do
		GenServer.call(@name, {:search, {center, radius}})
	end

	def handle_call({:search, {center, radius}}, _from, state) do
		endpoint = get_endpoint() <> "&center=#{center}&distance=#{radius}"

		{:ok, results} = PandaApi.Facebook.get!(endpoint).body
		{:reply, results["data"], results["paging"]}
	end

	def init(:ok) do
		{:ok, %{}}
	end

	defp get_endpoint do
		"/search?type=place&categories[]=MEDICAL_HEALTH&fields=#{@fields}&limit=5&access_token=#{get_token()}"
	end

	defp get_token do
		PandaApi.FacebookToken.get_token
	end
end