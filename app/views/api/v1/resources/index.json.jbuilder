json.array!(@resources) do |resource|
  json.extract! resource, :id, :supplier_name, :title, :duration
  json.history do
    json.array!(resource.audits) do |audit|
      json.changed_fields audit.audited_changes
      json.changed_at audit.created_at
    end
  end
end
