module ContentImageTags
  include Radiant::Taggable
  
    class TagError < StandardError; end

  tag 'content_images' do |tag|
    tag.expand
  end

  tag 'content_images:each' do |tag|
    result = []
    ContentImage.find(:all).each do |content_image|
      tag.locals.content_image = content_image
      result << tag.expand
    end
    result
  end

  tag 'content_images:each:content_image' do |tag|
    content_image = tag.locals.content_image
    %{<img src="#{ content_image.content_image.url(:small) }" alt="" />}
  end
  
  tag 'content_image' do |tag|
    if slug = tag.attr['slug']
      if content_image = ContentImage.find_by_slug(slug.strip)
        tag.locals.yield = tag.expand if tag.double?
        image_style = tag.attr['scale']
        if image_style == 'small'
          %{<img src="#{ content_image.content_image.url(:small) }" alt="" />}
        elsif image_style == 'large'
          %{<img src="#{ content_image.content_image.url(:large) }" alt="" />}
        else
          %{<img src="#{ content_image.content_image.url }" alt="" />}
        end
        
      else
        logger.debug 'Content Image not found'
      end
    else
      logger.debug 'content image tag must contain slug attribute'
    end
  end
end
