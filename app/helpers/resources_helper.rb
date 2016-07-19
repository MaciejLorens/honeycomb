module ResourcesHelper

  def changed(prev_revision, revision, param)
    return unless prev_revision && revision

    'changed' unless prev_revision.send(param) == revision.send(param)
  end

  def two_digits_options(up_to_number)
    (0..up_to_number).map{|i| sprintf("%02d", i)}
  end
end
