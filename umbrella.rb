# Write your soltuion here!
require "http"
require "json"
require "dotenv/load"

gmaps_api_key= ENV.fetch("GMAPS_KEY")
pirate_api_key= ENV.fetch("PIRATE_WEATHER_KEY")


puts "Where are you?"

user_location=gets.chomp

puts "Checking the weather at #{user_location} ..."

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_api_key}"
gmaps_raw_response = HTTP.get(gmaps_url)
parsed_gmaps_response = JSON.parse(gmaps_raw_response)
results_array= parsed_gmaps_response.fetch("results") 
first_results_hash= results_array.at(0)
geometry_array=first_results_hash.fetch("geometry")
location_array=geometry_array.fetch("location")
user_latitude=location_array.fetch("lat")
user_longitude=location_array.fetch("lng")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_api_key}/#{user_latitude},#{user_longitude}"

pirate_raw_response = HTTP.get(pirate_weather_url)
parsed_pirate_response = JSON.parse(pirate_raw_response)
currently_hash = parsed_pirate_response.fetch("currently")
user_temperature= currently_hash.fetch("temperature")
user_condition= currently_hash.fetch("summary")

puts "Your coordinates are #{user_latitude} , #{user_longitude}."
puts "It is currently #{user_temperature}F."
puts "Next hour: #{user_condition}."


