
require 'mcsrv/version'

module MCSRV
  class MinecraftServer
    @@server_ids = {}

    def new(options={})
      allowed_options = [:id, :version, :hostname, :port, :ram, :world_path]
    end

    def start
      Dir.chdir 'versions'
      puts Dir.pwd
      exec('java -Xmx1024M -Xms1024M -jar minecraft_server.1.8.3.jar nogui')
    end

  end
end
