module Version1
  module Entities
    class Location < Grape::Entity
      expose :id, documentation: {type: "string", desc: "ID"}
      expose :name, documentation: {type: "string", desc: "Location Name"}
    end
  end
end