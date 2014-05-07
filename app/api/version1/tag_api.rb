module Version1
  class TagApi < Grape::API

    resource :tags do

      get do
        present :status, "Success"
        present :data, Tag.all, with: Entities::Tag
      end

      desc "Get item list by tag"
      get ':tag' do

        items =  Item
        .includes(:tags)
        .where(:"tags.name" => params[:tag])

        present :status, "Success"
        present :data, items , with: Entities::Item
      end

    end
  end
end