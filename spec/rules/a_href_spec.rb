# frozen_string_literal: true

require "rules_helper"
require "html-a11y-lint/rules/a_href"

RSpec.describe HtmlA11yLint::Rules::AHRef do
  it "detects <a> without href" do
    expect(run_rule_for(described_class, '<a>Link</a>')).to include(/<a> tag without href attribute/)
  end

  it "ignores <a> with valid href" do
    expect(run_rule_for(described_class, '<a href="https://example.com">Link</a>')).to be_empty
  end
end
