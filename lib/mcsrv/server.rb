require 'mcsrv/version'
require 'mcsrv/syntactic_sugar'
require 'open3'
module MCSRV
  class Server
    extend MCSRV::SyntacticSugar

    define_accessor! :default_version, Version.latest
    define_accessor! :default_hostname, 'localhost'
    define_accessor! :default_port, 25565
    define_accessor! :default_ram, "1024M"
    @@server_ids = {}

    define_accessor :version
    define_accessor :hostname
    define_accessor :port
    define_accessor :ram

    def initialize(options={})
      set_default = Proc.new {|key,value| options[key] = value if !options.has_key?(key) }
      allowed_options = [:id, :version, :hostname, :port, :ram, :world_path]
      set_default.(:id, "server#{@@server_ids.size}")
      set_default.(:version, Server.default_version)
      set_default.(:hostname, Server.default_hostname)
      set_default.(:port, Server.default_port)
      set_default.(:ram, Server.default_ram)
      self.version = options[:version]
      self.hostname = options[:hostname]
      self.port = options[:port]
      self.ram = options[:ram]
    end

    def start
      Dir.chdir 'versions'
      Open3.popen2e('java -Xmx1024M -Xms1024M -jar minecraft_server.1.8.3.jar nogui') do |stdin, stdout_err, wait_thr|
        while line = stdout_err.gets
          puts line
        end
        stdout_err.close
      end
      #exec('java -Xmx1024M -Xms1024M -jar minecraft_server.1.8.3.jar nogui')
    end

  end
end
