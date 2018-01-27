defmodule PandaApi.Wimt do
	use HTTPoison.Base

	@headers [
		"Content-Type": "application/json",
		"Accept": "application/json"
	]

	def process_url(url) do
		"https://platform.whereismytransport.com" <> url
	end

	def process_request_headers(headers) do
		@headers ++ headers
	end

	def process_response_body(body) do
		Poison.decode body
	end
end
