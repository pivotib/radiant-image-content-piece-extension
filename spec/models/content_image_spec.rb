require File.dirname(__FILE__) + '/../spec_helper'

describe ContentImage do
  before(:each) do
    @content_image = ContentImage.new
  end

  it "should be valid" do
    @content_image.should be_valid
  end
end
