require File.dirname(__FILE__) + '/../spec_helper'

module ValidationTestHelper
  def assert_valid(field, *values)
    __model_check__
    values.flatten.each do |value|
      o = __setup_model__(field, value)
      if o.valid?
        assert_block { true }
      else
        messages = [o.errors[field]].flatten
        assert_block("unexpected invalid field <#{o.class}##{field}>, value: <#{value.inspect}>, errors: <#{o.errors[field].inspect}>.") { false }
      end
    end
  end
  
  def assert_invalid(field, message, *values)
    __model_check__
    values.flatten.each do |value|
      o = __setup_model__(field, value)
      if o.valid?
        assert_block("field <#{o.class}##{field}> should be invalid for value <#{value.inspect}> with message <#{message.inspect}>") { false }
      else
        messages = [o.errors[field]].flatten
        assert_block("field <#{o.class}##{field}> with value <#{value.inspect}> expected validation error <#{message.inspect}>, but got errors <#{messages.inspect}>") { messages.include?(message) }
      end
    end
  end
  
  def __model_check__
    raise "@model must be assigned in order to use validation assertions" if @model.nil?
    
    o = @model.dup
    raise "@model must be valid before calling a validation assertion, instead @model contained the following errors #{o.errors.instance_variable_get('@errors').inspect}" unless o.valid?
  end
  
  def __setup_model__(field, value)
    o = @model.dup
    attributes = o.instance_variable_get('@attributes')
    o.instance_variable_set('@attributes', attributes.dup)
    o.send("#{field}=", value)
    o
  end
end

describe ContentImage do
  include ValidationTestHelper
  before(:each) do
    @content_image = valid_image_attributes
  end

  it "should be valid" do
    @content_image.should be_valid
  end
  
  it 'should validate presence of name' do
    @content_image = valid_image_attributes({:name => nil})
    @content_image.should have(1).errors_on(:name)
  end
  
  it 'should validate presence of content_image' do
    lambda {
    @content_image = valid_image_attributes({:content_image => nil})
    }.should_not change(ContentImage, :count)
  end
  
  it 'should validate presence of slug' do
    [:slug].each do |field|
      assert_invalid field, 'can\'t be blank', '', ' ', nil
    end
  end
  
  it 'should validate length of slug < 100 characters' do
    {:slug => 100,
     }.each do |field, max|
       assert_invalid field, ('%d-character limit' % max), 'x' * (max + 1)
       assert_valid field, 'x' * max
     end
  end
  
  it 'should validate format of slug' do
    assert_valid :slug, 'abc', 'abcd-efg', 'abcd_efg', 'abc.html', '/', '123'
    assert_invalid :slug, 'invalid format', 'abcd efg', ' abcd', 'abcd/efg'
  end
  
  it 'should validate uniqueness of slug' do
    pending
  lambda {
      ContentImage.create({:slug => 'Bar'})
      ContentImage.create({:slug => 'Bar'})
  }.should change(ContentImage, :count).by(1)
  end
  
  protected
  def valid_image_attributes(options = {})
    @content_image = @model = ContentImage.new(
      {:name => 'Foo',
        :slug => 'Bar',
        :content_image => '/images/test.png'}.merge(options)
    )
  end
end