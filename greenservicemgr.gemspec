Gem::Specification.new do |s|
  s.name = 'greenservicemgr'
  s.version = '0.1.0'
  s.summary = 'greenservicemgr'
  s.authors = ['James Robertson']
  s.files = Dir["lib/greenservicemgr.rb"]
  s.add_runtime_dependency('onedrb', '~> 0.4', '>=0.4.1')
  s.signing_key = '../privatekeys/greenservicemgr.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/greenservicemgr'
end
