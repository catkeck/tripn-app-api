class Api::V1::UsersController < ApplicationController

  def create

    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      payload = {user_id: @user.id}
      render json: {user: @user, jwt: issue_token(payload)}
    else

    end
  end

  def save_image
    current_user.image = params[:image]
    current_user.save
  end

  def user_data
    trips = []
    activities = []
    current_user.schedules.all.each do |schedule|
      events = []
      events << schedule.date << schedule.location << schedule.activities
      activities << schedule.activities
      trips << events
    end
    flatten_activities = activities.flatten.map{ |activity| activity[:activity]}
    render json: {username: current_user.username, file: current_user.image, trips: trips, activities: flatten_activities}

  end



end