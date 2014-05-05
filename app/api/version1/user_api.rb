module Version1
  class UserApi < Grape::API

    resource :users do

      ## CREATE
      desc "Create new token"
      params do
        requires :facebook_id, type: String, desc: "Facebook Id"
        requires :android_key, type: String, desc: "Client Password (Such as Android Sign Key", default: 'android'
      end
      post :token do
        user = User.find_by(facebook_id: params[:facebook_id]) rescue nil
        if user && params[:android_key] == 'android'
          token = User.new_token
          user.update_attribute(:token, User.digest(token))
          present :status, "Success"
          present :data, token
        else
          error! 'Unauthorized, invalid ', 401
        end
      end

      desc "Create new user"
      params do
        requires :facebook_name, type: String, desc: "Facebook Name"
        requires :facebook_id, type: String, desc: "Facebook Id"
        optional :email, type: String, desc: "Email"
        optional :name, type: String, desc: "User Name"
      end
      post do
        user = User.new(
            facebook_name: params[:facebook_name],
            facebook_id: params[:facebook_id],
        )
        user.email = params[:facebook_id].to_s + "@facebook.com" unless params[:email].present?
        user.name = params[:facebook_name].to_s  unless params[:name].present?
        user.password  = "facebook"

        if user.save
          token = User.new_token
          user.update_attribute(:token, User.digest(token))
          present :status, "Success"
          present :data, user.token
        end
      end

    end
  end
end