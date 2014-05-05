module Version1
  module Entities
    class Tag < Grape::Entity
      expose :name
    end
  end
end