module Version1
  class UserApi < Grape::API
    helpers APIHelper

    resource :users do

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
          present :status, "Fail"
          present :data, 'Unauthorized, invalid '
        end
      end

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
        user.name = params[:facebook_name].to_s unless params[:name].present?
        user.password = "facebook"

        token = User.new_token
        user.update_attribute(:token, User.digest(token))
        present :status, "Success"
        present :data, token
      end


    end
  end
end