class Admin::ContentImagesController < ApplicationController
  def index
    @content_images = ContentImage.find(:all, :order => 'name ASC')
  end
  
  def show
    @content_image = ContentImage.find(params[:id])
  end
  
  def new
    @content_image = ContentImage.new
  end
  
  def create
    @content_image = ContentImage.new(params[:content_image])
    @saved = @content_image.save
    respond_to do |format|
      format.html {
        redirect_to admin_content_image_path(@content_image) and return if @saved
        render :action => "new"
      }
    end
  end
  
  def edit
    @content_image = ContentImage.find(params[:id])
  end
  
  def update
    @content_image = ContentImage.find(params[:id])
    
    respond_to do |format|
      format.html {
        if @content_image.update_attributes(params[:content_image])
          redirect_to admin_content_image_path(@content_image)
        else
          render :action => 'edit'
        end
      }
    end
  end
  
  def destroy
    @content_image = ContentImage.find(params[:id])
    @content_image.destroy
    
    respond_to do |format|
      format.html {redirect_to admin_content_images_path}
    end
  end
end
