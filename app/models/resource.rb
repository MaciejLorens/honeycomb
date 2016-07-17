class Resource < ApplicationRecord

  ASPECT_RATIO_TYPES = %w(
    21:9
    16:9
    4:3
  )

  validates :aspect_ratio, inclusion: { in: ASPECT_RATIO_TYPES }
end
