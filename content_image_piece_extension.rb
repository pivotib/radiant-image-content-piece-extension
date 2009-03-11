# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ContentImagePieceExtension < Radiant::Extension
  version "1.0"
  description "Radiant extension for adding Images to your content"
  url "http://github.com/pivotib/radiant-image-content-piece-extension/tree/master"
  Page.send :include, ContentImageTags
  

  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :content_images
    end
  end


  
  def activate
    @content_pieces = ContentPiece.instance
    @content_pieces << { :name => 'Content Images', :path_method => 'admin_content_images_path' }
     #admin.tabs.add "Content Image Piece", "/admin/content_images", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
     #admin.tabs.remove "Content Image Piece"
  end
  
end