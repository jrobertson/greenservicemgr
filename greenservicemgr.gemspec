Gem::Specification.new do |s|
  s.name = 'greenservicemgr'
  s.version = '0.2.3'
  s.summary = 'Intended for running within a Docker container to control daemonised GoGreen services.'
  s.authors = ['James Robertson']
  s.files = Dir["lib/greenservicemgr.rb"]
  s.add_runtime_dependency('onedrb', '~> 0.4', '>=0.4.2')
  s.signing_key = '../privatekeys/greenservicemgr.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/greenservicemgr'
end
