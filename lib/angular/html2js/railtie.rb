require 'angular/html2js'
require 'rails'

module Angular
  module Html2js
    class Railtie < Rails::Railtie
      railtie_name :angular_html2js

      initializer "angular_html2js.configure_rails_initialization" do
        config.angular_html2js = Angular::Html2js.config
        Sprockets.register_engine '.ngt', Angular::Html2js::Engine
      end
    end
  end
end
