module Koprol
  # Stream
  # 
  # Represent a single Stream in Koprol
  # 
  
  class Place
    include Koprol::Model
    
    attributes :name,:address
    
    # Retrieve one or more shops by name or ID:
    #
    #   Koprol::Place.find(:q => name)
    #

    def self.find(*identifiers_and_options)
      self.find_one_or_more('search/places.json', identifiers_and_options)
    end
    
    
  end
end