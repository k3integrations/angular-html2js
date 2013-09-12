require 'angular/html2js'
require 'rails'

module Angular
  module Html2js
    class Railtie < Rails::Railtie
      railtie_name :angular_html2js

      config.before_configuration do
        config.angular_html2js = Angular::Html2js.config
      end

      initializer "angular_html2js.init_sprockets" do |app|
        config.angular_html2js.init_sprockets
      end
    end
  end
end
