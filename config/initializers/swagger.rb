if Rails.env.development?
  GrapeSwaggerRails.options.url = 'http://localhost:3000/api/v1/swagger_doc.json'
  GrapeSwaggerRails.options.app_name = '二手簡介網API'
  GrapeSwaggerRails.options.api_key_name = 'api_key'
  GrapeSwaggerRails.options.api_key_type = 'query'
end