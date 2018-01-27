defmodule PandaApi.WimtToken do
	use GenServer

	alias PandaApi.WimtIdentity

	@name WIMT

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, :ok, opts ++ [name: WIMT])
	end

	def get_token do
		GenServer.call(@name, :get_token)
	end

	def handle_call(:get_token, _from, state) do
		{:reply, state, state}
	end 

	def init(:ok) do
		{ :ok, token } = WimtIdentity.post!("/connect/token", token_params()).body 
		{ :ok, token }
	end

	defp token_params do
		"client_id=#{System.get_env("WIMT_CLIENT_ID")}&client_secret=#{System.get_env("WIMT_CLIENT_SECRET")}&grant_type=client_credentials&scope=transportapi:all"
	end
end