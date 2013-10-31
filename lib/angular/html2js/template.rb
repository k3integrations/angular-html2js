require 'tilt'
require 'angular/html2js/configuration'

module Angular
  module Html2js
    class Template < Tilt::Template
      attr_accessor :file

      def self.default_mime_type
        'application/javascript'
      end

      TEMPLATE = <<-TEMPLATE
angular.module('%s', []).run(['$templateCache', function($templateCache) {
  $templateCache.put('%s',
  '%s');
}]);
      TEMPLATE


      SINGLE_MODULE_TPL = <<-SINGLE_MODULE_TPL
(function(module) {
  try {
    module = angular.module('%s');
  } catch (e) {
    module = angular.module('%s', []);
  }
  module.run(['$templateCache', function($templateCache) {
    $templateCache.put('%s',
    '%s');
  }]);
})();
      SINGLE_MODULE_TPL

      def config
        Html2js.config
      end

      def prepare; end

      def evaluate(scope, locals, &block)
        @module_name = config.module_name
        @cache_id = config.cache_id || default_cache_id_proc
        @scope = scope
        if @module_name
          SINGLE_MODULE_TPL % [@module_name, @module_name, cache_id, escapeContent(data)]
        else
          TEMPLATE % [cache_id, cache_id, escapeContent(data)]
        end
      end

      private

      def escapeContent(content)
        content.gsub(/\\/, '\\\\\\').gsub("'", %q{\\\\'}).gsub(/\r?\n/, "\\\\n\' +\n   \'")
      end

      def cache_id
        @cache_id.call(file, @scope)
      end

      def default_cache_id_proc
        Proc.new { file }
      end

    end
  end
end
