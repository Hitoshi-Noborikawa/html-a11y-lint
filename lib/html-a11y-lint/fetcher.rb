# frozen_string_literal: true

require "open-uri"

module HtmlA11yLint
  # Fetches HTML from a URL or local file
  class Fetcher
    class FetchError < StandardError; end

    def initialize(input)
      @input = input
    end

    def fetch
      if url?(@input)
        fetch_from_url(@input)
      else
        fetch_from_file(@input)
      end
    rescue FetchError => e
      puts "[Fetcher Error] #{e.message}"
      exit 1
    rescue StandardError => e
      puts "[Unexpected Error] #{e.message}"
      exit 1
    end

    private

    def url?(input)
      input.start_with?("http://", "https://")
    end

    def fetch_from_url(url)
      URI.open(url).read
    rescue OpenURI::HTTPError => e
      raise FetchError, "Failed to fetch URL: #{e.message}"
    rescue SocketError => e
      raise FetchError, "Failed to connect to URL: #{e.message}"
    end

    def fetch_from_file(path)
      raise FetchError, "File not found: #{path}" unless File.exist?(path)

      File.read(path)
    end
  end
end
