# frozen_string_literal: true

require "rules_helper"
require "html-a11y-lint/rules/button_label"

RSpec.describe HtmlA11yLint::Rules::ButtonLabel do
  it "detects empty button" do
    html = "<button></button>"
    expect(run_rule_for(described_class, html)).to include(/<button> tag without visible label/)
  end

  it "ignores button with text" do
    html = "<button>OK</button>"
    expect(run_rule_for(described_class, html)).to be_empty
  end
end
