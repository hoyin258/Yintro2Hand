json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :picture_id, :watch_count, :price, :like_count, :dislike_count, :location_id
  json.url item_url(item, format: :json)
end
