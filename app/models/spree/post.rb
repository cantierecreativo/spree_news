class Spree::Post < ActiveRecord::Base
  validates_presence_of :title, :description
#  validates_length_of :description, :maximum => 150

  attr_accessible :title, :description, :published, :image

  scope :published, lambda { where(:published => true) }
  scope :latest, order("created_at DESC").limit(2)

  has_attached_file :image,
    styles: { news: '200x200>', mini: '32x32>' },
    default_style: :news,
    url: '/spree/news/:id/:style/:basename.:extension',
    path: ':rails_root/public/spree/news/:id/:style/:basename.:extension',
    default_url: '/assets/default_news.png'

  include Spree::Core::S3Support
  supports_s3 :image

end
