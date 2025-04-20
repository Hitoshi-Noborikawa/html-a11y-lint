# frozen_string_literal: true

module HtmlA11yLint
  module Rules
    class DuplicateId
      def self.call(doc, add_error)
        id_map = Hash.new { |h, k| h[k] = [] }
        doc.css("*[id]").each do |node|
          id_map[node["id"]] << node
        end
        id_map.each do |id, nodes|
          if nodes.size > 1
            nodes.each do |node|
              add_error.call("Duplicate id '#{id}' found at line #{node.line}")
            end
          end
        end
      end
    end
  end
end
