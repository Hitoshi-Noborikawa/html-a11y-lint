# frozen_string_literal: true

require "rules_helper"
require "html-a11y-lint/rules/form_label"

RSpec.describe HtmlA11yLint::Rules::FormLabel do
  it "detects input with no label" do
    html = '<input type="text" name="no_label">'
    expect(run_rule_for(described_class, html)).to include(/<input> tag without associated <label>/)
  end

  it "ignores input with for-label" do
    html = '<label for="name">Name</label><input id="name">'
    expect(run_rule_for(described_class, html)).to be_empty
  end

  it "ignores input wrapped by label" do
    html = '<label>Name <input type="text" name="name"></label>'
    expect(run_rule_for(described_class, html)).to be_empty
  end
end
