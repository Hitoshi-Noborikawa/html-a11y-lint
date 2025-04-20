# frozen_string_literal: true

require "rules_helper"
require "html-a11y-lint/rules/img_alt"

RSpec.describe HtmlA11yLint::Rules::ImgAlt do
  it "detects <img> with no alt" do
    html = '<img src="foo.jpg">'
    expect(run_rule_for(described_class, html)).to include(/<img> tag without alt attribute/)
  end

  it "ignores <img> with alt text" do
    html = '<img src="foo.jpg" alt="ok">'
    expect(run_rule_for(described_class, html)).to be_empty
  end
end
