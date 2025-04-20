# frozen_string_literal: true

module HtmlA11yLint
  module Rules
    class ButtonLabel
      def self.call(doc, add_error)
        doc.css("button").each do |button|
          text = button.text.strip
          if text.empty?
            add_error.call("<button> tag without visible label at line #{button.line}")
          end
        end
      end
    end
  end
end
