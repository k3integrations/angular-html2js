require 'v8'
require 'coffee-script'

module Angular
  module Html2js
    TEMPLATE_HELPER = CoffeeScript.compile(File.read("spec/support/template_cache.coffee"))
  end
end

RSpec::Matchers.define :define_module do |module_name|

  match do |template|
    @modules = modules_from(template)
    @mod = @modules[module_name]
    @content = @mod && @mod.templates[@template_id]
    has_module && has_template_id && has_content
  end

  chain :with_template_id do |template_id|
    @template_id = template_id
  end

  chain :and_content do |content|
    @expected_content = content
  end

  def has_module
    !!@mod
  end

  def has_template_id
    return true unless @template_id
    @template_id && @content
  end

  def has_content
    return true unless @expected_content
    @expected_content && (@content == @expected_content)
  end

  failure_message_for_should do |template|
    failure_message
  end

  define_method :failure_message do |not_msg: nil|
    msg = "Template expected"
    msg += ' not' if not_msg

    msg + if !has_module
      " to define module '#{module_name}', found: #{@modules.keys}"
    elsif !has_template_id
      " to define template_id '#{@template_id}', found: #{@mod.templates.keys}"
    elsif !has_content
      " to have content #{@expected_content.inspect}, found: #{@content.inspect}"
    else
      "; Unknown reason"
    end
  end

  failure_message_for_should_not do |template|
    failure_message('not')
  end

  def modules_from(template)
    cxt = V8::Context.new
    cxt.eval(Angular::Html2js::TEMPLATE_HELPER, "spec/helpers/template_cache.coffee")
    cxt['template'] = template
    cxt.eval('evaluateTemplate(template)')
  end
end
