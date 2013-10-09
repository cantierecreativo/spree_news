class Spree::NewsConfiguration < Spree::Preferences::Configuration
  preference :news_default_url, :string, :default => '/spree/news/:id/:style/:basename.:extension'
  preference :news_path, :string, :default => ':rails_root/public/spree/news/:id/:style/:basename.:extension'
  preference :news_url, :string, :default => '/spree/news/:id/:style/:basename.:extension'
  preference :news_styles, :string, :default => "{\"mini\":\"48x48>\",\"news\":\"200x200>\"}"
  preference :news_default_style, :string, :default => 'news'
end
