class API < Grape::API

  prefix 'v1'
  version 'v1', using: :header, vendor: 'some_vendor'
  format :json
  content_type :json, "application/json;charset=utf-8"

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  helpers APIHelper

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rack::Response.new({
                           status: "Fail",
                           message: e.message
                       }.to_json).finish
  end

  rescue_from Exception do |e|
    if Rails.env.development?
      error = "#{e.class} error"
      message = e.message
    else
      error = "Fail"
      message = "An error occurred"
    end
    Rack::Response.new({error: error,
                        message: message
                       }.to_json).finish
  end


  mount Version1::UserApi
  mount Version1::ItemApi
  mount Version1::CommentAPI
  mount Version1::TagApi

  mount Version1::LocationApi
  mount Version1::PictureAPI



  add_swagger_documentation :base_path => '/api',
                            :markdown => true,
                            :hide_documentation_path => false

end
