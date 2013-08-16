require 'spec_helper'
require 'angular/html2js/template'

module Angular
  module Html2js
    describe Template do

      it 'should convert html to js code' do
        result = process '<h1>hello</h1>', 'tpl.html'
        result.should define_module('tpl.html').
          with_template_id('tpl.html').
          and_content('<h1>hello</h1>')
      end

      it 'should preserve new lines' do
        result = process "first\nsecond", 'path/tpl.html'
        result.should define_module('path/tpl.html').
          with_template_id('path/tpl.html').
          and_content("first\nsecond")
      end

      def process(template_str, file_name, locals={})
        template = Template.new { template_str }
        template.file = file_name
        template.render(self, locals)
      end

    end
  end
end
