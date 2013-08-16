module Angular
  module Html2js
    def self.configure
      yield config
    end


    def self.config
      @config ||= Configuration.new
    end


    def self.clear_config!
      @config = nil
    end


    class Configuration
      attr_accessor :module_name

      def cache_id_from_path(&block)
        if block
          @cache_id_from_path = block
        else
          @cache_id_from_path
        end
      end


      def method_missing(config_name, *)
        raise "Sorry, there is no such configuration option named #{config_name}"
      end
    end
  end
end
