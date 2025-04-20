# frozen_string_literal: true

require "nokogiri"
require "html-a11y-lint/rules/img_alt"
require "html-a11y-lint/rules/a_href"
require "html-a11y-lint/rules/button_label"
require "html-a11y-lint/rules/duplicate_id"
require "html-a11y-lint/rules/html_lang"
require "html-a11y-lint/rules/form_label"

module HtmlA11yLint
  class Checker
    attr_reader :errors

    def initialize(html)
      @html = html
      @errors = []
    end

    def run
      doc = Nokogiri::HTML(@html)

      rules.each do |rule|
        rule.call(doc, method(:add_error))
      end
    end

    private

    def add_error(message)
      @errors << message
    end

    def rules
      [
        HtmlA11yLint::Rules::ImgAlt,
        HtmlA11yLint::Rules::AHRef,
        HtmlA11yLint::Rules::ButtonLabel,
        HtmlA11yLint::Rules::DuplicateId,
        HtmlA11yLint::Rules::HtmlLang,
        HtmlA11yLint::Rules::FormLabel
      ]
    end
  end
end
