class WeatherController < ApplicationController
  def current_weather
    response = Faraday.get 'http://api.openweathermap.org/data/2.5/weather?q=London,uk'
    json_data = JSON.parse(response.body)
    @weather_data = json_data
  end

  def forecast_weather
    response = Faraday.get 'http://api.openweathermap.org/data/2.5/forecast/daily?id=524901'
    json_data = JSON.parse(response.body)
    @weather_data = json_data
  end
end