# frozen_string_literal: true

require "rules_helper"
require "html-a11y-lint/rules/duplicate_id"

RSpec.describe HtmlA11yLint::Rules::DuplicateId do
  it "detects duplicate ids" do
    html = '<div id="a"></div><span id="a"></span>'
    expect(run_rule_for(described_class, html)).to include(/Duplicate id 'a'/)
  end

  it "ignores unique ids" do
    html = '<div id="a"></div><span id="b"></span>'
    expect(run_rule_for(described_class, html)).to be_empty
  end
end
