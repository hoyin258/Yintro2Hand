module Version1
  class ItemApi < Grape::API

    resource :items do

      # before { authenticate!}

      # Get
      desc 'Returns item list'
      get do
        @items  = Item.all.limit(20)
        present @items,  with: Entities::Item, pictures_limit: 1
      end

      desc 'Returns item detail'
      params do
        requires :id, type: Integer, desc: "Item id."
      end
      get do
        @item  = Item.find(params[:id])
        present @item, with: Entities::Item, pictures_limit: 30
      end

      # POST
      desc "Create new item"
      params do
        requires :name, type: String
        requires :description, type: String
        requires :price, type: Integer
        requires :location, type: Integer
        group :tags do
          requires :id
        end
        requires :user, type: Integer
      end
      post do
        # list = current_user.lists.build(title: params[:title])
        # if list.save
        #   present list, with: Entity::List
        # else
        #   error! list.errors
        # end
      end



    end
  end
end