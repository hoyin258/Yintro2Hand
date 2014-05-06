module Version1
  module Entities
    class Comment < Grape::Entity

      expose :id , if: {type: :full}
      expose :message
      expose :updated_at

    end
  end
end