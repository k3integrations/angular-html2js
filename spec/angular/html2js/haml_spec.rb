require 'angular/html2js/haml'

module Angular
  module Html2js
    describe  Haml do
      it 'has a blank mime type' do
        described_class.default_mime_type.should be_nil
      end
    end
  end
end
