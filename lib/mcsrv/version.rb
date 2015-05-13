require 'open-uri'
require 'json'
require 'mcsrv/io'

module MCSRV
  module Version
    @@versions = nil
    @@releases = nil

    def self.refresh
      begin
        @@versions = JSON.load open('https://s3.amazonaws.com/Minecraft.Download/versions/versions.json')
      rescue => err
       puts "Error accessing minecraft version information from amazon s3: #{err}"
       @@versions = nil
       @@releases = nil
       false
      end
      @@releases = []
      @@versions['versions'].each do |v|
        @@releases << v['id'] if v['type'] == 'release'
      end
      true
    end

    def self.releases
      if (!@@versions && self.refresh) || @@versions
        @@releases
      else
        []
      end
    end

    def self.latest
      if (!@@versions && self.refresh) || @@versions
        @@versions['latest']['release']
      else
        nil
      end
    end

    def self.release_url(version)
      "https://s3.amazonaws.com/Minecraft.Download/versions/#{version}/minecraft_server.#{version}.jar"
    end

    def self.latest_url
      self.release_url(self.latest) if self.latest
    end

    def self.version_path(version)
      "versions/minecraft_server.#{version}.jar"
    end

    def self.download_latest
      version = latest
      return false if !version
      return download version
    end

    def self.download(version)
      path = version_path version
      return path if File.exist? path
      url = self.release_url version
      return false if !url
      MCSRV::IO.download_file url, path
      FileUtils.chmod '+x', path
      path
    end

  end
end
