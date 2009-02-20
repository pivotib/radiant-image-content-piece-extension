# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ContentImagePieceExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/content_image_piece"
  
  define_routes do |map|
    map.with_options(:controller => 'admin/content_image') do |content_image|
      content_image.content_image_index           'admin/content_images',             :action => 'index'
      content_image.content_image_new             'admin/content_images/new',         :action => 'new'
      content_image.content_image_edit            'admin/content_images/edit/:id',    :action => 'edit'
      content_image.content_image_remove          'admin/content_images/remove/:id',  :action => 'remove'
    end
  end

  
  def activate
     admin.tabs.add "Content Image Piece", "/admin/content_images", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
     admin.tabs.remove "Content Image Piece"
  end
  
end