require 'spec_helper'
require 'sprockets'
require 'angular/html2js/engine'

module Angular
  module Html2js
    describe Engine do
      let(:env) do
        Sprockets::Environment.new do |env|
          env.register_engine '.ngt', Engine
          env.append_path 'spec/assets/'
        end
      end

      let(:asset) { env.find_asset('test.js.ngt') }

      it 'makes angular templates available' do
        asset.to_s.should include("angular.module")
        asset.to_s.should include("<html>")
      end

      it 'recognizes them as javascript' do
        asset.content_type.should == 'application/javascript'
      end
    end
  end
end
