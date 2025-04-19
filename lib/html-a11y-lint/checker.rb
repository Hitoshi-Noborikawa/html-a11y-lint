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
      check_a_href(doc)
      check_button_label(doc)
      check_duplicate_ids(doc)
      check_html_lang(doc)
      check_form_label(doc)
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

    def check_a_href(doc)
      doc.css("a").each do |a|
        href = a["href"]
        if href.nil? || href.strip.empty?
          add_error("<a> tag without href attribute at line #{a.line}")
        end
      end
    end

    def check_button_label(doc)
      doc.css("button").each do |button|
        text = button.text.strip
        if text.empty?
          add_error("<button> tag without visible label at line #{button.line}")
        end
      end
    end

    def check_duplicate_ids(doc)
      id_map = Hash.new { |h, k| h[k] = [] }
      doc.css("*[id]").each do |node|
        id_map[node["id"]] << node
      end
      id_map.each do |id, nodes|
        if nodes.size > 1
          nodes.each do |node|
            add_error("Duplicate id '#{id}' found at line #{node.line}")
          end
        end
      end
    end

    def check_html_lang(doc)
      html_tag = doc.at("html")
      return unless html_tag

      lang = html_tag["lang"]
      if lang.nil? || lang.strip.empty?
        add_error("<html> tag is missing a lang attribute (line #{html_tag.line})")
      end
    end

    def check_form_label(doc)
      form_controls = doc.css("input, select, textarea")
      label_for_ids = doc.css("label[for]").map { |label| label["for"] }
      form_controls.each do |el|
        next if el["type"] == "hidden"

        id = el["id"]
        has_for_label = id && label_for_ids.include?(id)
        has_wrapping_label = el.ancestors.any? { |ancestor| ancestor.name == "label" }

        unless has_for_label || has_wrapping_label
          add_error("<#{el.name}> tag without associated <label> at line #{el.line}")
        end
      end
    end

    def add_error(message)
      @errors << message
    end
  end
end
