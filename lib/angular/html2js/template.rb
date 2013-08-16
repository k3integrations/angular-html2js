require 'tilt'

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
      end

      def evaluate(scope, locals, &block)
        if module_name
          SINGLE_MODULE_TPL % [moduleName, moduleName, htmlPath, escapeContent(content)]
        else
          TEMPLATE % [file, file, escapeContent(data)]
        end
      end

      private

      def escapeContent(content)
        content.gsub(/\n/, "\\\\n\' +\n   \'")
      end

    end
  end
end
