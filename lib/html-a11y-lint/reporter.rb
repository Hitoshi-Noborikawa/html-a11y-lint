# frozen_string_literal: true

module HtmlA11yLint
  class Reporter
    def initialize(errors)
      @errors = errors
    end

    def report
      if @errors.empty?
        puts "No accessibility issues found."
      else
        puts "Found #{@errors.size} issue#{@errors.size > 1 ? 's' : ''}"
        @errors.each do |error|
          puts " - #{error}"
        end
      end
    end
  end
end
