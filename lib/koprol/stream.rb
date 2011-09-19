module Koprol
  # Stream
  # 
  # Represent a single Stream in Koprol
  # 
  
  class Stream
    include Koprol::Model
    
    attributes :full_photo_url, :permalink, :comments_counter, :bump_counter, :body
  end
end