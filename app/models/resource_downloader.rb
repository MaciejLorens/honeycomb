require 'open-uri'

class ResourceDownloader

  def initialize
  end

  def self.download
    instance = self.new
    instance.download
  end

  def download
    case resource_download_strategy
    when 'xml_urls' then download_from_xml_urls
    else
       raise "unknown #{resource_download_strategy} resource download strategy"
    end
  end

  private

  def download_from_xml_urls
    resource_xml_urls.each do |resource_xml_url|
      Resource.create(resource_attributes_from_xml(resource_xml_url))
    end
  end

  def resource_attributes_from_xml(resource_xml_url)
    xml_doc = Nokogiri::HTML(open(resource_xml_url))
    delivery_id = xml_doc.at_css('deliveryid deliveryid').content
    return if Resource.find_by(delivery_id: delivery_id).present?

    {
      delivery_id:            delivery_id,
      filename:               xml_doc.at_css('filename filename').content,
      resolution:             xml_doc.at_css('resolution resolution').content,
      supplier_name:          xml_doc.at_css('supplierinfo suppliername').try(:content) ||
                              xml_doc.at_css('supplierinfo supplierinfo').try(:content),
      delivery_date:          xml_doc.at_css('supplierinfo deliverydate').content,
      title:                  xml_doc.at_css('mediainfo title').content,
      episode:                xml_doc.at_css('mediainfo episode').content,
      year:                   xml_doc.at_css('mediainfo year').content,
      som:                    xml_doc.at_css('mediainfo som').content,
      eom:                    xml_doc.at_css('mediainfo eom').content,
      duration:               xml_doc.at_css('mediainfo duration').content,
      aspect_ratio:           xml_doc.at_css('mediainfo aspectratio').content,
      material_type:          xml_doc.at_css('mediainfo materialtype').content,
      delivery_channel_group: xml_doc.at_css('mediainfo deliverychannelgroup').content,
      format:                 xml_doc.at_css('videoconfiguration format').content,
      audio_track_1:          xml_doc.at_css('audioconfiguration audiotrack1').content,
      audio_track_2:          xml_doc.at_css('audioconfiguration audiotrack2').content
    }
  end

  def resource_download_strategy
    Rails.application.secrets[:resource_download_strategy]
  end

  def resource_xml_urls
    Rails.application.secrets[:resource_xml_urls]
  end

end
