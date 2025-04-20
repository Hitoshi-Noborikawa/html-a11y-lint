# frozen_string_literal: true

require "spec_helper"
require "nokogiri"

def run_rule_for(rule_class, html)
  doc = Nokogiri::HTML(html)
  errors = []
  rule_class.call(doc, ->(msg) { errors << msg })
  errors
end
