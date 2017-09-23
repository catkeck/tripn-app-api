class Api::V1::SchedulesController < ApplicationController
  def find_places
    query_term = params[:searchTerm].split(" ").join("+")
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=arts,localflavor&limit=50&offset=#{params[:offset]}&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {businesses: json}
  end

  def find_indoor_places
    query_term = params[:searchTerm].split(" ").join("+")
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=galleries,castles,mahjong,musicvenues,observatories,opera,theater,planetarium&limit=50&offset=#{params[:offset]}&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {businesses: json}
  end

  def find_restaurants
    query_term = params[:searchTerm].split(" ").join("+")
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=restaurants&limit=50&offset=#{params[:offset]}&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {restaurants: json}
  end

  def create
    schedule = Schedule.create(user_id: current_user.id, date: Date.today, location: params[:trip][:location])
    activities = params[:trip][:activities]
    activities.each do |activity| 
      Activity.create(schedule_id: schedule.id, activity: activity[:name], imageURL: activity[:image_url], latitude: activity[:coordinates][:latitude], longitude: activity[:coordinates][:longitude])
    end
    restaurants = params[:trip][:restaurants]
    restaurants.each do |restaurant|
      Activity.create(schedule_id: schedule.id, activity: restaurant[:name], imageURL: restaurant[:image_url])
    end
  end
end

