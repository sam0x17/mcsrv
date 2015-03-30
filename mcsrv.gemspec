Gem::Specification.new do |s|
  s.name  = 'mcsrv'
  s.version  = '0.0.1'
  s.date  = '2014-03-30'
  s.summary  = 'Minecraft Bindings'
  s.description  = 'Minecraft bindings for Minecraft Host Ninja'
  s.authors  = ['Sam Kelly']
  s.email  = 'sam@durosoft.com'
  s.files  = ['lib/mcsrv.rb', 'lib/mcsrv/version.rb']
  s.homepage  = 'http://minecrafthost.ninja'
  s.license  = 'proprietary'

  s.add_dependency 'net-ssh', '~> 2.9.2'
end
