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
