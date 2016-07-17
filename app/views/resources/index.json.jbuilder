json.array!(@resources) do |resource|
  json.extract! resource, :id, :title, :episode, :year, :duration, :aspect_ratio
  json.url resource_url(resource, format: :json)
end
