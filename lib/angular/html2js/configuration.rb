require 'sprockets'
require 'angular/html2js/haml'

module Angular
  module Html2js
    def self.configure
      yield config
    end


    def self.config
      @config ||= Configuration.new
    end


    def self.reset_config!
      config.reset!
    end


    class Configuration
      attr_accessor :module_name

      def cache_id(&block)
        if block
          @cache_id = block
        else
          @cache_id
        end
      end

      def reset!
        @cache_id = @module_name = nil
      end

      def method_missing(config_name, *)
        puts "Sorry, there is no such configuration option named #{config_name}"
        super
      end

      def init_sprockets
        # hack around bug in rails assets debug mode
        # TODO: remove this once this bug is resolved: https://github.com/sstephenson/sprockets/issues/478
        Sprockets.register_engine '.haml', Angular::Html2js::Haml
        Sprockets.register_engine '.ngt', Angular::Html2js::Engine
      end
    end
  end
end
