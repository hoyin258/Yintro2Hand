module Version1
  module Entities
    class Picture < Grape::Entity
      expose :large
      expose :original
      expose :thumb
    end
  end
end