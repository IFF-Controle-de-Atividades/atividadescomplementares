# encoding: utf-8

class ComprovanteUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file

  def default_url
    asset_path("fallback/" + [version_name, "pdf.png"].compact.join('_'))
  end

  # process resize_to_fit: [50, 50]
  # version :thumb do
  #    process :resize_to_fill => [90, 90]
  # end

  def extension_white_list
    %w( png jpeg jpg pdf )
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
