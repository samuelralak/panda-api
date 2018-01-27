defmodule PandaApi.WimtIdentity do
	use HTTPoison.Base

	@headers [
		"Content-Type": "application/x-www-form-urlencoded",
		"Accept": "application/json"
	]

	def process_url(url) do
		"https://identity.whereismytransport.com" <> url
	end

	def process_request_headers(headers) do
		@headers ++ headers
	end

	def process_response_body(body) do
		Poison.decode body
	end
end