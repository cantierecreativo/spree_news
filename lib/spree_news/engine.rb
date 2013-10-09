module SpreeNews
  class Engine < Rails::Engine
    isolate_namespace Spree
    engine_name 'spree_news'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree_news.preferences", :before => :load_config_initializers do |app|
      SpreeNews::Config = Spree::NewsConfiguration.new
    end


    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
