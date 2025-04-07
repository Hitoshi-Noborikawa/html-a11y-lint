# frozen_string_literal: true

require_relative "fetcher"

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

      puts html
    end
  end
end
