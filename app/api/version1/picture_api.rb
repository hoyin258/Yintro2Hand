module Version1
  class PictureAPI < Grape::API

    get :pictures do
      present Picture.all
    end

  end
end