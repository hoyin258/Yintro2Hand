module Version1
  module Entities
    class Comment < Grape::Entity
      expose :message
    end
  end
end