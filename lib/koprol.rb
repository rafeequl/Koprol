$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'oauth'

require 'koprol/request'
require 'koprol/response'
# 
require 'koprol/basic_client'
# require 'koprol/secure_client'
# 
require 'koprol/model'
require 'koprol/place'
require 'koprol/user'

module Koprol
  class Error < RuntimeError; end

  class << self
    attr_accessor :api_key, :api_secret, :username, :password, :host
    attr_writer :callback_url
  end

  HOST = 'www.dev.koprol.com'

  # Set the access mode, can either be :public or :authenticated.  Defaults to :public.
  # and will raise an exception when set to an invalid value.
  #
  def self.access_mode=(mode)
    unless [:authenticated, :public, :read_only, :read_write].include?(mode)
      raise(ArgumentError, "access mode must be set to either :authenticated or :public")
    end
    if mode == :read_only
      deprecate "Please set koprol.access_mode to :public. Mode :read_only is no longer in use."
      mode = :public
    end
    if mode == :read_write
      deprecate "Please set koprol.access_mode to :authenticated. Mode :read_write is no longer in use."
      mode = :authenticated
    end
    @access_mode = mode
  end

  # The currently configured access mode
  #
  def self.access_mode
    @access_mode || :public
  end


end