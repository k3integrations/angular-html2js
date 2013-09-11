require 'spec_helper'

ENV['RAILS_ENV'] = 'test'

require_relative '../../../app/config/environment'

require 'capybara/rspec'
require 'capybara/rails'

module Angular
  module Html2js
    describe Railtie, type: :feature do
      before(:all) do
      end

      before(:each) { FileUtils.rm_rf Rails.root.join('tmp', 'cache', 'assets', 'test') }

      it "should setup rails to serve ng templates" do
        visit '/assets/templates/test.js'
        page.should have_content "$templateCache"
        page.should have_content "Hello World"
      end

      it "enables Haml for js assets" do
        visit '/assets/templates/test_haml.html'
        page.should have_content "$templateCache"
        page.body.should include "<h1>hello haml</h1>"
      end

      describe "Configuration" do
        after { Html2js.reset_config! }

        it "allows you to configure the module" do
          Rails.configuration.angular_html2js.module_name = 'myRailsModule'
          Html2js.config.module_name.should == 'myRailsModule'
        end

        it "allows you to set the cache key" do
          Rails.configuration.angular_html2js.cache_id { |file| "rails-#{file}" }
          Html2js.config.cache_id.call('test').should == 'rails-test'
        end
      end
    end
  end
end
