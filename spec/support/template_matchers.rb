require 'v8'
require 'coffee-script'

module Angular
  module Html2js
    TEMPLATE_HELPER = CoffeeScript.compile(File.read("spec/support/template_cache.coffee"))
  end
end

RSpec::Matchers.define :define_module do |module_name|

  match do |template|
    modules_from(template).include? module_name
  end

  failure_message_for_should do |template|
    "Template expected to define module '#{module_name}', found: #{modules_from(template)}"
  end

  failure_message_for_should_not do |template|
    "Template not expected to define module '#{module_name}', found: #{modules_from(template)}"
  end

  def modules_from(template)
    cxt = V8::Context.new
    cxt.eval(Angular::Html2js::TEMPLATE_HELPER, "spec/helpers/template_cache.coffee")
    cxt['template'] = template
    cxt.eval('evaluateTemplate(template)').keys
  end
end
