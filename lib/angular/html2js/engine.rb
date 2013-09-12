require 'angular/html2js/template'
module Angular
  module Html2js
    class Engine < Template

      private

      def default_cache_id_proc
        Proc.new { |file_path, scope| scope.logical_path }
      end

    end

    config.init_sprockets
  end
end


# Monkey patch to ensure templates are always the correct type
# TODO: Get rid of this. https://github.com/sstephenson/sprockets/issues/478
module Sprockets
  class AssetAttributes
    alias_method :orig_content_type, :content_type
    def content_type
      @content_type ||= begin
        if extensions.include?('.ngt')
          @content_type ||= 'application/javascript'
        else
          orig_content_type
        end
      end
    end
  end
end
