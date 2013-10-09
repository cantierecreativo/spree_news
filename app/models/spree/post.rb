class Spree::Post < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], message: I18n.t(:images_only)
#  validates_length_of :description, :maximum => 150

  attr_accessible :title, :description, :published, :image

  scope :published, -> { where(:published => true) }
  scope :latest, -> { |count=3| order("created_at DESC").limit(count) }

  has_attached_file :image,
    styles: { news: '200x200>', mini: '48x48>' },
    default_style: :news,
    url: "/spree/news/:id/:style/:basename.:extension",
    path: ":rails_root/public/spree/news/:id/:style/:basename.:extension",
    convert_options: { all: '-strip -auto-orient' }

  include Spree::Core::S3Support
  supports_s3 :image

  Spree::Post.attachment_definitions[:image][:styles] = ActiveSupport::JSON.decode(Spree::Config[:news_styles]).symbolize_keys!
  Spree::Post.attachment_definitions[:image][:path] = Spree::Config[:news_path]
  Spree::Post.attachment_definitions[:image][:url] = Spree::Config[:news_url]
  Spree::Post.attachment_definitions[:image][:default_url] = Spree::Config[:news_default_url]
  Spree::Post.attachment_definitions[:image][:default_style] = Spree::Config[:news_default_style].to_sym

end
