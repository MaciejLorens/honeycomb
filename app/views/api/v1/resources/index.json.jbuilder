json.array!(@resources) do |resource|
  json.extract! resource, :id, :delivery_id, :title, :episode, :year, :duration, :aspect_ratio
  json.history_url history_api_v1_resource_url(resource, format: 'json')
end
