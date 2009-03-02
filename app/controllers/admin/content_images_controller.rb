class Admin::ContentImagesController < ApplicationController
  def index
    @content_images = ContentImage.find(:all)
  end
  
  def show
    @content_image = ContentImage.find(params[:id])
  end
  
  def new
    @content_image = ContentImage.new
  end
  
  def create
    @content_image = ContentImage.new(params[:content_image])
    
    respond_to do |format|
      if @content_image.save
        format.html {redirect_to admin_content_image_path(@content_image)}
      else
        format.html {redirect_to new_admin_content_image_path}
      end
    end
  end
end
