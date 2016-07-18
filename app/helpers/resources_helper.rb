module ResourcesHelper

  def changed(prev_revision, revision, param)
    return unless prev_revision && revision

    'changed' unless prev_revision.send(param) == revision.send(param)
  end

end
