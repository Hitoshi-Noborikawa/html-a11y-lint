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
      doc = Nokogiri::HTML(@html)

      # TODO: add lint rule
    end

    private

    def add_error(message)
      @errors << message
    end
  end
end
