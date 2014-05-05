class API < Grape::API


  helpers do
    def current_user
      token = params[:api_key]
      @current_user ||= User.where(token: token).first
    end
    def authenticate!
      error!({error: "401 Unauthorized"}, 401) unless current_user
    end
  end

  prefix 'v1'
  version 'v1', using: :header, vendor: 'location'
  format :json
  content_type :json, "application/json;charset=utf-8"

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rack::Response.new({
                           status: "Fail",
                           message: e.message
                       }.to_json).finish
  end
  rescue_from Exception do |e|
    if Rails.env.development?
      Rack::Response.new({
                             error: "#{e.class} error",
                             message: e.message
                         }.to_json).finish
    else
      Rack::Response.new({
                             status: "Fail",
                             message: e.message
                         }.to_json).finish
    end
  end

  mount Version1::UserApi
  mount Version1::ItemApi
  mount Version1::LocationApi
  mount Version1::PictureAPI

  if Rails.env.development?
    add_swagger_documentation :base_path => "http://localhost:3000/api",
                              :markdown => true,
                              :hide_documentation_path => false
  else
    add_swagger_documentation :base_path => "http://booklibraryapi.herokuapp.com/api",
                              :markdown => true,
                              :hide_documentation_path => true
  end
end
