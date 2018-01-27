defmodule PandaApi.Facebook do
	use HTTPoison.Base

	def process_url(url) do
		"https://graph.facebook.com/v2.11" <> url
	end

	def process_response_body(body) do
		Poison.decode body
	end
end