namespace :radiant do
  namespace :extensions do
    namespace :content_image_piece do
      
      desc "Runs the migration of the Content Image Piece extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ContentImagePieceExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ContentImagePieceExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Content Image Piece to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[ContentImagePieceExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(ContentImagePieceExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
