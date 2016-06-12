json.array!(@contents) do |content|
  json.extract! content, :id
  json.url organization_content_url(@organization, content, format: :json)
end
