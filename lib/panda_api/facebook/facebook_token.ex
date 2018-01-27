defmodule PandaApi.FacebookToken do
	use GenServer

	alias PandaApi.Facebook

	@name FB

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, :ok, opts ++ [name: FB])
	end

	def get_token do
		GenServer.call(@name, :get_token)
	end

	def handle_call(:get_token, _from, state) do
		{:reply, state["access_token"], state}
	end 

	def init(:ok) do		
		{:ok, token} = get_fb_token()
		{:ok, token}
	end

	defp get_fb_token do
		app_id = System.get_env("FACEBOOK_APP_ID") 
		app_secret = System.get_env("FACEBOOK_APP_SECRET")
		endpoint =  token_endpoint(app_id, app_secret)

		Facebook.get!(endpoint).body
	end

	defp token_endpoint(app_id, app_secret) do
		"/oauth/access_token?client_id=#{app_id}&client_secret=#{app_secret}&grant_type=client_credentials"
	end
end