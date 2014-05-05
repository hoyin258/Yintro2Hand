module Version1
  class ItemApi < Grape::API

    resource :items do

      # Get
      desc 'Returns item list from all user'
      get :index do
        items = Item.all.limit(20).order(id: :desc)
        present :status, "Success"
        present :data, items, with: Entities::Item, pictures_limit: 1
      end

      # Get
      desc 'Returns item list by user id'
      params do
        requires :id, type: Integer, desc: "User id."
      end
      get :user do
        items = User.find(params[:id]).items
        present :status, "Success"
        present :data, items, with: Entities::Item, pictures_limit: 1
      end

      # Get
      desc 'Returns item detail'
      params do
        requires :id, type: Integer, desc: "Item id."
      end
      get :detail do
        item = Item.find(params[:id])
        present :status, "Success"
        present :data, item, with: Entities::Item, pictures_limit: 30, type: :full
      end

      # POST
      desc "Create new item"
      params do
        requires :name, type: String
        requires :description, type: String
        requires :price, type: Integer
        # requires :user_id, type: Integer
        requires :location_id, type: Integer
        optional :tags, type: String
      end

      post do

        authenticate!

        item = Item.new(
            name: params[:name],
            description: params[:description],
            price: params[:price],
            # user_id: params[:user_id],
            location_id: params[:location_id],
        )

        item.user_id  =@current_user

        if params[:tags].present?
          item.tags = Tag.where(name: params[:tags].split(/\s*,\s*/))
        else
          item.tags = [ ]
        end

        if item.save
          present :status, "Success"
          present :data, item, with: Entities::Item, pictures_limit: 30, type: :full
        end
      end
    end
  end
end