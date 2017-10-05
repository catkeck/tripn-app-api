class Api::V1::SchedulesController < ApplicationController

  def find_places
    query_term = params[:searchTerm].split(" ").join("+")
    user = current_user
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=#{user.interests}&limit=50&offset=#{params[:offset]}&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
    json = JSON.parse(response.body)
    businesses = json
    render :json => {businesses: json}
  end

  def filter_interests_array(interests_array)
    if interests_array==[]
      "galleries,castles,mahjong,musicvenues,observatories,opera,theater,planetarium"
    elsif interests_array.length == 1
      interests_array
    else
      interests_array.join(",")
    end
  end

  def find_indoor_places
    user = current_user
    query_term = params[:searchTerm].split(" ").join("+")
    interests_overlap_array = user.interests.split(",")&["escapegames","fitnesses","barreclasses","bootcamps","boxing","gymnastics","indoor_playcentre","arcades","galleries","cabaret","casinos","castles","chois","movietheaters","countryclubs","culturalcenter","hauntehouses","museums","artmuseums","childrensmuseums","musicvenues","observatories","opera","paintandsip","theater","planetarium","ticketsales","virtualrealitycenters","winetastingroom","artclasses","glassblowing","tastingclasses","cheesetastingclasses","winetasteclasses","barcrawl","beergardens","coffeeshops","comedyclubs","countrydancehalsl","danceclubs","fasil","jazzandblues","karaoke","musicvenues","pianobars","poolhalls","buddhis_temples","churches","hindu_temples","mosques","shrines","spiritism","synagogues","taoisttemples","antiques","galleries","stationery","cookingclasses","paintyourownpottery","bookstores","comicbooks"]
    interests_input = filter_interests_array(interests_overlap_array)
    response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=#{query_term}&categories=#{interests_input}&limit=50&offset=#{params[:offset]}&sort_by=rating", headers: {"Authorization" => "Bearer zzSJcoghsbcSeNzF6YQ7vcj_kufo6RJfq6KwcIepTzHQTusehX6b95_PYSyKqE3wf4lycwtowriOST4wQvgnCBXYQxWFMQLAN2DOq2gFnLkK2KTAV9oyd0uXBri-WXYx"}, format: :plain)
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
    imageResponse = HTTParty.get("https://api.qwant.com/api/search/images?count=1&offset=1&q=#{params[:trip][:location]}+desktop")
    schedule = Schedule.create(user_id: current_user.id, date: Date.today, location: params[:trip][:location], image_url: (imageResponse["data"]["result"]["items"][0]["media"] ? imageResponse["data"]["result"]["items"][0]["media"] : null))
    activities = params[:trip][:activities]
    activities.each do |activity| 
      Activity.create(schedule_id: schedule.id, activity: activity[:name], imageURL: activity[:image_url], latitude: activity[:coordinates][:latitude], longitude: activity[:coordinates][:longitude], address: activity[:location][:display_address].join(" "), phone_number: activity[:display_phone])
    end
    restaurants = params[:trip][:restaurants]
    restaurants.each do |restaurant|
      Activity.create(schedule_id: schedule.id, activity: restaurant[:name], imageURL: restaurant[:image_url], latitude: restaurant[:coordinates][:latitude], longitude: restaurant[:coordinates][:longitude], address: restaurant[:location][:display_address].join(" "), phone_number: restaurant[:display_phone])
    end
  end
end

