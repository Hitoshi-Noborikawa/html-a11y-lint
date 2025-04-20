# frozen_string_literal: true

module HtmlA11yLint
  module Rules
    class HtmlLang
      def self.call(doc, add_error)
        html_tag = doc.at("html")
        return unless html_tag

        lang = html_tag["lang"]
        if lang.nil? || lang.strip.empty?
          add_error.call("<html> tag is missing a lang attribute (line #{html_tag.line})")
        end
      end
    end
  end
end
