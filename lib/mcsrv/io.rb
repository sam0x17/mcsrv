require 'open-uri'
module MCSRV
  module IO

    def self.download_file(url, dest_path)
      begin
        File.open(dest_path, 'wb') do |dest_file|
          open(url, 'rb') do |source_file|
            dest_file.write(source_file.read)
          end
        end
      rescue => err
        puts "error downloading file: #{err}"
        false
      end
      true
    end

  end
end
