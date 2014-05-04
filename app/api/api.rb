class API < Grape::API
  prefix 'v1'
  version 'v1', using: :header, vendor: 'location'
  format :json
  content_type :json, "application/json;charset=utf-8"

  # before do
  #   header['Access-Control-Allow-Origin'] = '*'
  #   header['Access-Control-Request-Method'] = '*'
  # end

  mount Version1::LocationApi
  mount Version1::ItemApi

  # add_swagger_documentation

  if Rails.env.development?
    add_swagger_documentation :base_path => "http://localhost:3000/api",
                              :markdown => true,
                              :hide_documentation_path => false
  else
    # add_swagger_documentation :base_path => "http://booklibraryapi.herokuapp.com/api",
    #                           :markdown => true,
    #                           :hide_documentation_path => true
  end
end
