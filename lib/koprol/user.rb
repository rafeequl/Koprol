module Koprol
  # Stream
  # 
  # Represent a single Stream in Koprol
  # 
  
  class User
    include Koprol::Model
    
    attributes :username
    
    # Retrieve one or more shops by name or ID:
    #
    #   Koprol::Place.find(:q => name)
    #

    def self.find(id, *identifiers_and_options)
      self.find_one_or_more("users/#{id}.json", identifiers_and_options)
    end
    
    
  end
end