require 'spec_helper'
require 'sprockets'
require 'angular/html2js/engine'

module Angular
  module Html2js
    describe Engine do
      let(:env) do
        Sprockets::Environment.new do |env|
          env.append_path 'spec/assets/'
        end
      end

      let(:asset) { env.find_asset('test.ngt') }

      it 'makes angular templates available' do
        asset.to_s.should include("angular.module")
        asset.to_s.should include("<html>")
      end

      it 'recognizes them as javascript' do
        asset.content_type.should == 'application/javascript'
      end

      it 'uses the logical path if no module_name is provided' do
        asset.to_s.should include(".put('test'")
      end

      describe 'html file' do
        let(:asset) { env.find_asset('test_html.js') }

        it 'renders to an angular template ' do
          pending 'html extension support' do
            asset.to_s.should include("angular.module")
            asset.to_s.should include("<h1>hello html</h1>")
          end
        end

        it 'returns the correct content type for html templates' do
          pending 'html extension support' do
            asset.content_type.should eq 'application/javascript'
          end
        end

        it "doesn't interfere with normal html files" do
          env.find_asset('normal.html').to_s.should eq "<h1>hello normal html</h1>\n"
        end
      end

      describe 'haml file' do
        let(:asset) { env.find_asset('test_haml.js') }

        it 'renders to an angular template ' do
          asset.to_s.should include("angular.module")
          asset.to_s.should include("<h1>hello haml</h1>")
        end

        it 'returns the correct content type for html templates' do
          asset.content_type.should eq 'application/javascript'
        end
      end
    end
  end
end
