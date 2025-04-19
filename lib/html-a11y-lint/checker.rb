# frozen_string_literal: true

require "nokogiri"

module HtmlA11yLint
  class Checker
    attr_reader :errors

    def initialize(html)
      @html = html
      @errors = []
    end

    def run
      doc = Nokogiri::HTML(@html) do |config|
        config.default_html.noerror.noblanks
      end

      check_img_alt(doc)
    end

    private

    def check_img_alt(doc)
      doc.css("img").each do |img|
        alt = img["alt"]
        if alt.nil? || alt.strip.empty?
          add_error("<img> tag without alt attribute at line #{img.line}")
        end
      end
    end

    def add_error(message)
      @errors << message
    end
  end
end
