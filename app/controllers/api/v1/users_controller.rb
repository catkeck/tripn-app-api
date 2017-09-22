class Api::V1::UsersController < ApplicationController

  def create

    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      payload = {user_id: @user.id}
      render json: {user: @user, jwt: issue_token(payload)}
    else

    end
  end

  def user_data
    trips = []
    current_user.schedules.all.each do |schedule|
      events = []
      events << schedule.date
      events << schedule.activities
      trips << events
    end
    render json: {username: current_user.username, trips: trips}
  end



end