module Version1
  module Entities
    class Item < Grape::Entity
      expose :name
      expose :description
      expose :price
      expose :watch_count
      expose :like_count
      expose :dislike_count
      expose :pictures, using: Picture, unless: {type: :full} do |model, opts|
        model.pictures.limit(opts[:pictures_limit] ||= 10)
      end
      expose :location, using: Location
      expose :user, using: User

      expose :comments, using: Comment, if: {type: :full}
      expose :tags, using: Tag
    end

  end
end