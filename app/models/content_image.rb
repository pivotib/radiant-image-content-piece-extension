class ContentImage < ActiveRecord::Base
  validates_presence_of :name, :slug
  validates_uniqueness_of :name
  validates_length_of :slug, :maximum => 100, :message => '%d-character limit'
  validates_format_of :slug, :with => %r{^([-_.A-Za-z0-9]*|/)$}, :message => 'invalid format'
  validates_uniqueness_of :slug
  has_attached_file :content_image, :styles => { :thumbnail => "100x100>", :small => "250x250>", :large => "500x500>" }, :whiny_thumbnails => true
  validates_attachment_presence :content_image
  
  def render_content_image(content_image)
    parse_object(content_image)
  end
  
  def lazy_initialize_parser_and_context
    unless @parser and @context
      @context = PageContext.new(self)
      @parser = Radius::Parser.new(@context, :tag_prefix => 'r')
    end
    @parser
  end
  
  def parse(text)
    lazy_initialize_parser_and_context.parse(text)
  end
  
  def parse_object(object)
    text = object.content
    text = parse(text)
    text = object.filter.filter(text) if object.respond_to? :filter_id
    text
  end

  
end
