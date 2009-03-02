require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ContentImagesController do
  dataset :users
  before do
    login_as :existing
  end
  
  describe "index method" do
    before do
      @content_images = [valid_image]
      ContentImage.stub!(:find).and_return(@content_images)
    end
    it "should create a @content_images" do
      ContentImage.should_receive(:find).with(:all).and_return(@content_images)
      do_request
    end
    def do_request
      get "index"
    end
  end
  
  
  describe "show method" do
    before do
      @content_image = valid_image
      ContentImage.stub!(:find).and_return(@content_image)
    end
    it "should find the image requested" do
      ContentImage.should_receive(:find).with("1").and_return(@content_image)
      do_request
    end
    def do_request(params={})
      default_params = {:id => "1"}
      get :show, default_params.merge(params)
    end
  end

  describe "new method" do
    before do
      @content_image = valid_image
      ContentImage.stub!(:new).and_return(@content_image)
    end
    it "should create a new image" do
      ContentImage.should_receive(:new).and_return(@content_image)
      do_request
    end
    def do_request
      get :new
    end
  end
  
  describe "create method" do
    before do
      @content_image = valid_image
      ContentImage.stub!(:new).and_return(@content_image)
    end
    it "should create a new image" do
      new_params = {:content_image => {"name" => "la tee da", "slug" => "la_tee_da"}}
      ContentImage.should_receive(:new).with(new_params[:content_image]).and_return(@content_image)
      do_request(new_params)
    end
    it "should be saved" do
      @content_image.should_receive(:save).and_return(true)
      do_request
    end
    describe "successful save" do
      before do
        @content_image.stub!(:save).and_return(true)
      end
      it "should redirect to show" do
        do_request
        response.should redirect_to("admin/content_images/")
      end
    end
    describe "unsuccessful save" do
      before do
        @content_image.stub!(:save).and_return(false)
      end
      it "should show the new view" do
        do_request
        response.should redirect_to("admin/content_images/new")
      end
    end
    def do_request(new_params={})
      default_params = {}
      post :create, default_params.merge(new_params)
    end
  end

  protected
  def valid_image(attributes = {})
    ContentImage.new(
      {:name => 'Foo', :slug => 'bar'}.merge(attributes)
    )
  end
end
