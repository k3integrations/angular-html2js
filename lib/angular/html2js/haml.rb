require 'tilt'

module Angular
  module Html2js
    class Haml < Tilt::HamlTemplate
      def default_mime_type
      end
    end
  end
end
