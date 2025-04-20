# frozen_string_literal: true

module HtmlA11yLint
  module Rules
    class ImgAlt
      def self.call(doc, add_error)
        doc.css("img").each do |img|
          alt = img["alt"]
          if alt.nil? || alt.strip.empty?
            add_error.call("<img> tag without alt attribute at line #{img.line}")
          end
        end
      end
    end
  end
end
