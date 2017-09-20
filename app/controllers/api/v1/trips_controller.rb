class Api::V1::TripsController < ApplicationController

  def find_places
    query_term = params[:searchTerm].split(" ").join("+")
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=arts,localflavor&limit=50&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {businesses: json}
  end

  def find_bad_weather_places
    query_term = params[:searchTerm].split(" ").join("+")
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=galleries,castles,mahjong,musicvenues,observatories,opera,theater,planetarium&limit=50&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {businesses: json}
  end

  def find_restaurants
    query_term = params[:searchTerm].split(" ").join("+")
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=restaurants&limit=50&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {restaurants: json}
  end



end
