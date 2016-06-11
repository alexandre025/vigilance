json.array!(@tags) do |tag|
  json.extract! tag, :id, :name
  json.url organization_tag_url(@organization, tag, format: :json)
end
