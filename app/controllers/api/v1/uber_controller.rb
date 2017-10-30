class Api::V1::UberController < ApplicationController

  def get_token
    code = params[:code]
    data = {client_id: 'SPJ6ABS79wvt56KnjwID5WdjTXNE-DIS', client_secret: ENV['UBER_SECRET'], code: code, scope: 'request', redirect_uri: 'http://localhost:3001/uber/', grant_type: 'authorization_code'}
    response = HTTParty.post('https://login.uber.com/oauth/v2/token', body: data)
    json = JSON.parse(response.body)
    render :json => {access_token: json["access_token"]}
  end

  def get_products
    accessToken = params[:accessToken]
    latitude = params[:latitude]
    longitude = params[:longitude]
    response = HTTParty.get("https://api.uber.com/v1.2/products?latitude=#{latitude}&longitude=#{longitude}", headers: {"Authorization" => "Bearer #{accessToken}"})
    json = JSON.parse(response.body)
    render :json => {products: json}
  end

  def get_price_estimate 
    product_id = params[:productId]
    accessToken = params[:accessToken]
    start_latitude = params[:startLatitude]
    start_longitude = params[:startLongitude]
    end_latitude = params[:endLatitude]
    end_longitude = params[:endLongitude]
    data = {product_id: product_id, start_latitude: start_latitude, start_longitude: start_longitude, end_latitude: end_latitude, end_longitude: end_longitude}
    response = HTTParty.post("https://api.uber.com/v1.2/requests/estimate", headers: {'Content-Type' => 'application/json', 'Accept-Language' => 'en_US', "Authorization" => "Bearer #{accessToken}"}, body: JSON.generate(data))
    json = JSON.parse(response.body)
    render :json => {price: json, product_id: product_id}
  end

  def book_ride
    access_token = params[:accessToken]
    fare_id = params[:fare_id]
    start_latitude = params[:startLatitude]
    start_longitude = params[:startLongitude]
    end_latitude = params[:endLatitude]
    end_longitude = params[:endLongitude]
    data = {fare_id: fare_id, start_latitude: start_latitude, start_longitude: start_longitude, end_latitude: end_latitude, end_longitude: end_longitude}
    response = HTTParty.post("https://sandbox-api.uber.com/v1.2/requests", headers: {'Content-Type' => 'application/json', 'Accept-Language' => 'en_US', "Authorization" => "Bearer #{access_token}"}, body: JSON.generate(data))
    HTTParty.delete("https://sandbox-api.uber.com/v1.2/requests/current", headers: {'Content-Type' => 'application/json', 'Accept-Language' => 'en_US', "Authorization" => "Bearer #{access_token}"})
    json = JSON.parse(response.body)
    render :json => {result: json}
  end
end

