# frozen_string_literal: true

require_relative "fetcher"
require_relative "checker"
require_relative "reporter"

module HtmlA11yLint
  # CLI entry point for the html-a11y-lint command.
  class CLI
    def self.start(args)
      if args.empty?
        puts "Usage: html-a11y-lint <URL_or_file_path>"
        exit 1
      end

      input = args[0]
      fetcher = Fetcher.new(input)
      html = fetcher.fetch

      checker = Checker.new(html)
      checker.run

      reporter = Reporter.new(checker.errors)
      reporter.report

      puts "Found #{checker.errors.size} issues."
      puts checker.errors.join("\n")
    end
  end
end
