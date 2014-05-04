module Version1
  class LocationApi < Grape::API

    desc 'Return location list', {
        entity: Entities::Location,
        notes: ''
    }
    get :locations do
      present Location.all, with: Entities::Location
    end

  end
end