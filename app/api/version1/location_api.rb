module Version1
  class LocationApi < Grape::API

    resource :locations do

      get do
        present :status, "Success"
        present :data, Location.all, with: Entities::Location
      end

      get ':id' do
        present :status, "Success"
        present :data, Location.find(params[:id]), with: Entities::Location
      end


    end
  end
end