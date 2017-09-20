class ApplicationController < ActionController::API

  def issue_token(payload)
    JWT.encode(payload, "basidiomycota")
  end

  def decoded_token(token)
    begin
      JWT.decode(token, "basidiomycota")
    rescue JWT::DecodeError
      ""
    end
  end

  def token 
    bearer_token = request.headers["Authorization"]
    jwt_token = bearer_token
  end

  def current_user
    decoded_hash = decoded_token(token)
    if !decoded_hash.empty?
      user_id = decoded_hash[0]["user_id"]
      user = User.find(user_id)
    end

  end

  def logged_in?
    !!current_user
  end
end
