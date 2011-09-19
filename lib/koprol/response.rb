module Koprol

  # = Response
  #
  # Basic wrapper around the Koprol JSON response data
  #
  class Response

    # Create a new response based on the raw HTTP response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    # Convert the raw JSON data to a hash
    def to_hash
      @hash ||= JSON.parse(data)
      # @hash.collect do |p| p['place'] end
    end

    # Number of records in the response results
    def count
      10
      # to_hash['count']
    end

    # Results of the API request
    def result
      count == 1 ? to_hash['results'].first : aa = to_hash['user']
      # aa.collect do |p| p['place'] end
    end

    private

    def data
      @raw_response.body
    end

  end
end
