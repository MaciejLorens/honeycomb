json.array!(@audits) do |audit|
  json.action audit.action
  json.changes audit.audited_changes
  json.changed_at audit.created_at
end
