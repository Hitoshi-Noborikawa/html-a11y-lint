# frozen_string_literal: true

module HtmlA11yLint
  module Rules
    class FormLabel
      def self.call(doc, add_error)
        form_controls = doc.css("input, select, textarea")
        label_for_ids = doc.css("label[for]").map { |label| label["for"] }
        form_controls.each do |el|
          next if el["type"] == "hidden"

          id = el["id"]
          has_for_label = id && label_for_ids.include?(id)
          has_wrapping_label = el.ancestors.any? { |ancestor| ancestor.name == "label" }

          unless has_for_label || has_wrapping_label
            add_error.call("<#{el.name}> tag without associated <label> at line #{el.line}")
          end
        end
      end
    end
  end
end
