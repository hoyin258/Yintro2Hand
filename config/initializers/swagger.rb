if Rails.env.development?
  GrapeSwaggerRails.options.url = 'http://localhost:3000/api/v1/swagger_doc.json'
  GrapeSwaggerRails.options.app_name = 'Yintro2Hand'
end