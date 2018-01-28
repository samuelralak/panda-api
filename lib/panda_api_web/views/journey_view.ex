defmodule PandaApiWeb.JourneyView do
	use PandaApiWeb, :view

	def render("index.json", %{ results: results }) do
		%{
			data: render_many(results, __MODULE__, "journey.json")
		}
	end

	def render("journey.json", %{ journey: journey }) do
		%{
			total_duration: journey["duration"],
			total_distance: journey["distance"]["value"],
			legs: for leg <- journey["legs"]  do
				format_leg(leg)
			end
		}
	end

	defp format_leg(leg) do
		%{
			recomendend: leg_recommendation(leg["type"], leg["distance"]["value"]),
			directions: format_directions(leg["directions"]),
			fare: format_fare(leg["fare"]),
			stage: get_stage(leg["line"])
		}
	end

	defp leg_recommendation(type, distance) when type == "Walking" and distance >= 500 do
		"Take a SafeBoda"
	end
	defp leg_recommendation(type, _distance) when type == "Transit", do: "Take a taxi"
	defp leg_recommendation(_type, _distance), do: "Walk"

	defp format_directions(directions) when is_nil(directions), do: []
	defp format_directions(directions) do
		for direction <- directions  do
			%{
				instruction: direction["instruction"],
				distance: direction["distance"]["value"],
			}
		end
	end

	defp format_fare(fare) when is_nil(fare), do: %{}
	defp format_fare(fare) do
		fare["cost"]
	end

	defp get_stage(stage) when is_nil(stage), do: %{}
	defp get_stage(stage) do
		stage["name"]
	end
end
