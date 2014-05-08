module Version1
  class UserApi < Grape::API
    helpers APIHelper

    resource :users do

      desc 'Returns item list by user id'
      params do
        use  :pagination
      end
      get ':id/items' do
        items = User.find(params[:id]).items
        .paginate(page: params[:page], per_page: params[:per_page])
        .order(updated_at: :desc)
        Item.update_counters items.pluck(:id), watch_count: 1
        present :status, "Success"
        present :data, items, with: Entities::Item, pictures_limit: 1
      end


      desc 'Returns comment list by user id'
      params do
        use  :pagination
      end
      get ':id/comments' do
        comments = Comment
        .where(user_id: params[:id])
        .paginate(page: params[:page], per_page: params[:per_page])
        .order(updated_at: :desc)
        present :status, "Success"
        present :data, comments, with: Entities::Comment, type: :full
      end


      desc "Get Token from facebook"
      params do
        requires :api_key, type: String, desc: "API Key"
        requires :facebook_name, type: String, desc: "Facebook Name"
        requires :facebook_id, type: String, desc: "Facebook Id"
        optional :email, type: String, desc: "Email"
        optional :name, type: String, desc: "User Name"
        optional :facebook_accesstoken, type: String, desc: "Facebook access token"
      end
      post do
        if params[:api_key] == 'android' or
          params[:api_key] == 'ios'
          user = User.find_by_facebook_id(params[:facebook_id])
          if !user
            user = User.new(
              facebook_name: params[:facebook_name],
              facebook_id: params[:facebook_id],
              )
            user.email = params[:facebook_id].to_s + "@facebook.com" unless params[:email].present?
            user.name = params[:facebook_name].to_s unless params[:name].present?
            user.facebook_accesstoken = params[:facebook_accesstoken].to_s unless params[:facebook_accesstoken].present?
            user.password = "facebook"
          end
          token = User.new_token
          user.update_attribute(:token, User.digest(token))
          present :status, "Success"
          present :data, token
        else
          present :status, "Fail"
          present :data, "Incorrect API Key, Please request API Key from the admin"
        end

      end


    end
  end
end