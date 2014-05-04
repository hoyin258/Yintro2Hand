module Version1
  module Entities
    class Item < Grape::Entity
      expose :name
      expose :description
      expose :price
      expose :watch_count
      expose :like_count
      expose :dislike_count
      # expose :picture_id
      expose :location_id
      # expose :created_at
      # expose :updated_at
    end
  end
end