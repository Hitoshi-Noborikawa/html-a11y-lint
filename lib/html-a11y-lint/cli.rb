module HtmlA11yLint
  class CLI
    def self.start(args)
      if args.empty?
        puts "Usage: html-a11y-lint <URL_or_file_path>"
        exit 1
      end

      input = args[0]
      puts "Received input: #{input}"
    end
  end
end
