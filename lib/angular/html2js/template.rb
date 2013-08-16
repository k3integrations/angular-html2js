require 'tilt'
require 'angular/html2js/configuration'

module Angular
  module Html2js
    class Template < Tilt::Template
      attr_accessor :file

      TEMPLATE = <<-TEMPLATE
angular.module(\'%s\', []).run(function($templateCache) {
  $templateCache.put(\'%s\',
  \'%s\');
});
      TEMPLATE


      SINGLE_MODULE_TPL = <<-SINGLE_MODULE_TPL
(function(module) {
  try {
    module = angular.module(\'%s\');
  } catch (e) {
    module = angular.module(\'%s\', []);
  }
  module.run(function($templateCache) {
    $templateCache.put(\'%s\',
    \'%s\');
  });
})();
      SINGLE_MODULE_TPL

      def module_name
        nil
      end

      def prepare
        config = Html2js.config
        @module_name = config.module_name
        @cache_id_from_path = config.cache_id_from_path
      end

      def evaluate(scope, locals, &block)
        if @module_name
          SINGLE_MODULE_TPL % [@module_name, @module_name, html_path, escapeContent(data)]
        else
          TEMPLATE % [html_path, html_path, escapeContent(data)]
        end
      end

      private

      def escapeContent(content)
        content.gsub(/\\/, '\\\\\\').gsub(/\r?\n/, "\\\\n\' +\n   \'")
      end

      def html_path
        @cache_id_from_path && @cache_id_from_path.call(file) || file
      end

    end
  end
end
