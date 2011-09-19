module Koprol

  # = SecureClient
  #
  # Used for generating tokens and calling API methods that require authentication.
  #
  class SecureClient
    
    def initialize(attributes = {})
      @attributes = attributes
    end

    def consumer # :nodoc:
      path = '/v2/oauth/'
      @consumer ||= OAuth::Consumer.new(Koprol.api_key, Koprol.api_secret, {
        :site               => "http://#{Koprol.host}",
        :request_token_path => "#{path}request_token",
        :access_token_path  => "#{path}access_token"
      })
    end

    # Generate a request token.
    #
    def request_token
      consumer.get_request_token(:oauth_callback => Koprol.callback_url)
    end

    # Access token for this request, either generated from the request token or taken
    # from the :access_token parameter.
    #
    def access_token
      @attributes[:access_token] || client.token
    end

    # Access secret for this request, either generated from the request token or taken
    # from the :access_secret parameter.
    #
    def access_secret
      @attributes[:access_secret] || client.secret
    end

    def client_from_request_data # :nodoc:
      request_token = OAuth::RequestToken.new(consumer, @attributes[:request_token], @attributes[:request_secret])
      request_token.get_access_token(:oauth_verifier => @attributes[:verifier])
    end

    def client_from_access_data # :nodoc:
      OAuth::AccessToken.new(consumer, @attributes[:access_token], @attributes[:access_secret])
    end

    def client # :nodoc:
      @client ||= has_access_data? ? client_from_access_data : client_from_request_data
    end

    # Fetch a raw response from the specified endpoint.
    #
    def get(endpoint)
      client.get(endpoint)
    end

    private
    
    def get_part(lp)
      url     = "https://login.yahoo.com/WSLogin/V1/get_auth_token"	
      content = {:query=>{:oauth_consumer_key=>@key, :passwd=>lp[:passwd], :login=>lp[:login]}}
      @part   = HTTParty.get(url, content).parsed_response.split('=')[1].gsub("\n","")
      self
    end

    def get_token
      consumer     = OAuth::Consumer.new(@key,@secret, { :site => "https://api.login.yahoo.com", :access_token_path => "/oauth/v2/get_token" })
      req_token    = OAuth::RequestToken.new(consumer, @part)
      token_hash   = consumer.token_request(:post, "/oauth/v2/get_token", req_token)
      @access_token= OAuth::AccessToken.new(consumer,token_hash["oauth_token"],token_hash["oauth_token_secret"])
      self
    end

    def has_access_data?
      !@attributes[:access_token].nil? && !@attributes[:access_secret].nil?
    end

  end
end
