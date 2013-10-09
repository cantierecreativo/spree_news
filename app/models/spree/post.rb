class Spree::Post < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], message: I18n.t(:images_only)
#  validates_length_of :description, :maximum => 150

  attr_accessible :title, :description, :published, :image

  scope :published, lambda { where(:published => true) }
  scope :latest, ->(count=3) { order("created_at DESC").limit(count) }
  has_attached_file :image,
    styles: ActiveSupport::JSON.decode(SpreeNews::Config[:news_styles]).symbolize_keys!,
    default_style: SpreeNews::Config[:news_default_style],
    url: SpreeNews::Config[:news_url],
    default_url: SpreeNews::Config[:news_default_url],
    path: SpreeNews::Config[:news_path],
    convert_options: { all: '-strip -auto-orient' }

  include Spree::Core::S3Support
  supports_s3 :image
end
