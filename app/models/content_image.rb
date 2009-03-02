class ContentImage < ActiveRecord::Base
  has_attached_file :content_image, :styles => { :small => "250x250>", :large => "960x800>" }, :whiny_thumbnails => true
  validates_presence_of :content_image
  
end
