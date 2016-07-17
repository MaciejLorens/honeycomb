require 'open-uri'

module ResourceDownloader

  def self.download
    feed_resources.each do |feed_resource|
      feed_xml_doc = Nokogiri::HTML(open(feed_resource))

      delivery_id = feed_xml_doc.at_css('deliveryid deliveryid').content
      media_info = feed_xml_doc.at_css('mediainfo')

      next if Resource.find_by(delivery_id: delivery_id).present?

      Resource.create(
          delivery_id: delivery_id,
          title: media_info.at_css('title').content,
          episode: media_info.at_css('episode').content,
          year: media_info.at_css('year').content,
          duration: media_info.at_css('duration').content,
          aspect_ratio: media_info.at_css('aspectratio').content
      )
    end
  end

  def self.feed_resources
    Rails.application.secrets[:feed_urls]
  end

end
