module Version1
  class ItemApi < Grape::API

    resource :items do

      # Get
      desc 'Returns item list', {
          entity: Entities::Item,
          notes: 'Get all lists for items.'
      }
      get do
        @items  = Item.all.includes(:location)
        present @items, with: Entities::Item
      end

      # POST
      # desc "Create new item", {
      #     entity: Entities::Item,
      #     notes: 'Create new item'
      # }
      # params do
      #   requires :title, type: String, desc: "Title"
      # end
      # post do
      #   list = current_user.lists.build(title: params[:title])
      #   if list.save
      #     present list, with: Entity::List
      #   else
      #     error! list.errors
      #   end
      # end



    end
  end
end