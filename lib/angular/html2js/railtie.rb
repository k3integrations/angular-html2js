require 'angular/html2js'
require 'rails'

module Angular
  module Html2js
    class Railtie < Rails::Railtie
      railtie_name :angular_html2js

      config.before_configuration do
        config.angular_html2js = Angular::Html2js.config
      end

      initializer "angular_html2js.configure_rails_initialization" do |app|
        post_process_html = config.angular_html2js.post_process_html

        if post_process_html.nil? || post_process_html
          Sprockets.register_postprocessor 'text/html', Angular::Html2js::Engine
        end

        Sprockets.register_engine '.haml', Tilt::HamlTemplate
        Sprockets.register_engine '.ngt', Angular::Html2js::Engine
      end
    end
  end
end
