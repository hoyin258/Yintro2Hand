module Version1
  module Entities
    class Item < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :price
      expose :watch_count
      expose :like_count
      expose :dislike_count
      expose :pictures, using: Version1::Entities::Picture, if: {type: :full}
      expose :picture, using: Version1::Entities::Picture, unless: {type: :full}
      expose :location, using: Location
      expose :user, using: Version1::Entities::User
      expose :comments, using: Version1::Entities::Comment, if: {type: :full}
      expose :tags, using: Version1::Entities::Tag

      expose :updated_at, if: {type: :full}
    end

  end
end