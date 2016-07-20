require 'open-uri'

class ResourceDownloader

  def self.download
    resource_urls.each do |feed_resource|
      feed_xml_doc = Nokogiri::HTML(open(feed_resource))


      delivery_id_node = feed_xml_doc.at_css('deliveryid')
      filename_node = feed_xml_doc.at_css('filename')
      resolution_node = feed_xml_doc.at_css('resolution')
      supplier_info_node = feed_xml_doc.at_css('supplierinfo')
      media_info_node = feed_xml_doc.at_css('mediainfo')
      video_configuration_node = feed_xml_doc.at_css('videoconfiguration')
      audio_configuration_node = feed_xml_doc.at_css('audioconfiguration')

      delivery_id = delivery_id_node.at_css('deliveryid').content
      next if Resource.find_by(delivery_id: delivery_id).present?

      Resource.create(
          delivery_id: delivery_id,
          filename: filename_node.at_css('filename').content,
          resolution: resolution_node.at_css('resolution').content,
          supplier_name: supplier_info_node.at_css('suppliername').try(:content) ||
                         supplier_info_node.at_css('supplierinfo').try(:content),
          delivery_date: supplier_info_node.at_css('deliverydate').content,
          title: media_info_node.at_css('title').content,
          episode: media_info_node.at_css('episode').content,
          year: media_info_node.at_css('year').content,
          som: media_info_node.at_css('som').content,
          eom: media_info_node.at_css('eom').content,
          duration: media_info_node.at_css('duration').content,
          aspect_ratio: media_info_node.at_css('aspectratio').content,
          material_type: media_info_node.at_css('materialtype').content,
          delivery_channel_group: media_info_node.at_css('deliverychannelgroup').content,
          format: video_configuration_node.at_css('format').content,
          audio_track_1: audio_configuration_node.at_css('audiotrack1').content,
          audio_track_2: audio_configuration_node.at_css('audiotrack2').content,
      )
    end
  end

  def self.resource_urls
    Rails.application.secrets[:resource_urls]
  end

end
