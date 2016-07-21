FactoryGirl.define do
  factory :resource do
    sequence(:delivery_id)  { |n| "ZDW/EOWW005/#{n}" }
    filename 'ZDW-EOWW005-010.mxf'
    resolution 'HD'
    sequence(:supplier_name)  { |n| "IMD_#{n}" }
    sequence(:delivery_date)  { |n| "2016-02-#{n}" }
    sequence(:title)  { |n| "PLAY DEAD PRE MONDAY SAINSBURYS_#{n}" }
    episode '1000'
    year 2016
    som '10:00:00:00'
    eom '10:00:10:00'
    sequence(:duration)  { |n| "00:00:10:0#{n}" }
    aspect_ratio '4:3'
    material_type 'Commercial'
    delivery_channel_group 'NOT'
    format 'HD'
    audio_track_1 'left'
    audio_track_2 'right'
  end
end
