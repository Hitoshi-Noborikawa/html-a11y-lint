# frozen_string_literal: true

require "rules_helper"
require "html-a11y-lint/rules/html_lang"

RSpec.describe HtmlA11yLint::Rules::HtmlLang do
  it "detects missing lang attribute" do
    html = "<html><head></head><body></body></html>"
    expect(run_rule_for(described_class, html)).to include(/<html> tag is missing a lang attribute/)
  end

  it "ignores valid lang attribute" do
    html = '<html lang="en"><head></head><body></body></html>'
    expect(run_rule_for(described_class, html)).to be_empty
  end
end
