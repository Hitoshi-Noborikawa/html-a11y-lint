# frozen_string_literal: true

module HtmlA11yLint
  module Rules
    class AHRef
      def self.call(doc, add_error)
        doc.css("a").each do |a|
          href = a["href"]
          if href.nil? || href.strip.empty?
            add_error.call("<a> tag without href attribute at line #{a.line}")
          end
        end
      end
    end
  end
end
