module Version1
  class ItemApi < Grape::API

    resource :items do

      # Get
      desc 'Returns item list from all user'
      params do
        optional :page, type: Integer, desc: "Page num."
        optional :per_page, type: Integer, desc: "No /page."
      end
      get :index do
        items = Item
        .paginate(page: params[:page]||1, per_page: params[:per_page] || 20)
        .order(updated_at: :desc)

        present :status, "Success"
        present :data, items, with: Entities::Item, pictures_limit: 1
      end


      # Get
      desc 'Returns item list by user id'
      params do
        requires :id, type: Integer, desc: "User id."
        optional :page, type: Integer, desc: "Page num."
        optional :per_page, type: Integer, desc: "No /page."
      end
      get :user do
        items = User.find(params[:id]).items
        .paginate(page: params[:page]||1, per_page: params[:per_page] || 20)
        .order(updated_at: :desc)

        Item.update_counters items.pluck(:id), watch_count: 1
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
        Item.update_counters params[:id], watch_count: 1
        present :status, "Success"
        present :data, item, with: Entities::Item, pictures_limit: 30, type: :full
      end


      # POST
      desc "Create new item"
      params do
        requires :name, type: String
        requires :description, type: String
        requires :price, type: Integer
        requires :location_id, type: Integer
        optional :tags, type: String
      end
      post do
        authenticate!
        item = Item.new(
            name: params[:name],
            description: params[:description],
            price: params[:price],
            location_id: params[:location_id],
        )
        item.user_id =@current_user.id
        if params[:tags].present?
          tag_arr = params[:tags].split(/\s*,\s*/)
          tag_arr.each do |tag|
            item.tags << Tag.where(name: tag).first_or_create
          end
        else
          item.tags = []
        end
        if item.save
          present :status, "Success"
          present :data, item, with: Version1::Entities::Item, pictures_limit: 30, type: :full
        end
      end

      resource :count do

        # POST
        desc "Add watch count"
        params do
          requires :id, type: Integer, desc: "Item id."
        end
        post :watch do
          if Item.update_counters params[:id], watch_count: 1
            present :status, "Success"
          end
        end
        # POST
        desc "Add like count"
        params do
          requires :id, type: Integer, desc: "Item id."
        end
        post :like do
          if Item.update_counters params[:id], like_count: 1
            present :status, "Success"
          end
        end
        # POST
        desc "Add dislike count"
        params do
          requires :id, type: Integer, desc: "Item id."
        end
        post :dislike do
          if Item.update_counters params[:id], dislike_count: 1
            present :status, "Success"
          end
        end
      end


      # PUT
      desc "Update Item"
      params do
        requires :item_id, type: Integer
        requires :name, type: String
        requires :description, type: String
        requires :price, type: Integer
        requires :location_id, type: Integer
        optional :tags, type: String
      end
      put  do
        authenticate!
        item = @current_user.items.find(params[:item_id])
        if item
          item.update({
                          name: params[:name],
                          description: params[:description],
                          price: params[:price],
                          location_id: params[:location_id],
                      })

          tags = []
          if params[:tags].present?
            tag_arr = params[:tags].split(/\s*,\s*/)
            tag_arr.each do |tag|
              tags << Tag.where(name: tag).first_or_create
            end
          end
          item.tags = tags
          if item.save
            present :status, "Success"
            present :data, item, with: Version1::Entities::Item, pictures_limit: 30, type: :full
          end
        end
      end


      # DELETE
      desc "Delete item"
      params do
        requires :item_id, type: Integer
      end
      delete  do
        authenticate!
        item = @current_user.items.find(params[:item_id])
        item.destroy
        present :status, "Success"
      end
    end
  end
end