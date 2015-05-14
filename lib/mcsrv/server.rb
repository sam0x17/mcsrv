require 'mcsrv/version'
require 'mcsrv/syntactic_sugar'
module MCSRV
  class Server
    extend MCSRV::SyntacticSugar

    define_accessor! :default_hostname, 'localhost'
    define_accessor! :default_port, 25565
    define_accessor! :default_ram, "1024M"
    define_accessor! :default_version, Version.latest
    define_accessor! :server_ids, {}, :protected

    def new(options={})
      set_default = Proc.new {|key,value| options[key] = value if !options.has_key?(key) }
      allowed_options = [:id, :version, :hostname, :port, :ram, :world_path]
      set_default.(:id, "server#{server_ids.size}")
      set_default.(:version, Version.latest)
      set_default.(:port, Server.default_port)
      set_default.(:ram, Server.default_ram)

    end

    def start
      Dir.chdir 'versions'
      puts Dir.pwd
      pin, ppout = IO.pipe
      ppin, pout = IO.pipe
      #exec('java -Xmx1024M -Xms1024M -jar minecraft_server.1.8.3.jar nogui')
    end

  end
end
