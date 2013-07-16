# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina-ftp'

Gem::Specification.new do |spec|
  spec.name          = "mina-ftp"
  spec.version       = Mina::Ftp::VERSION
  spec.authors       = ["Stas SUȘCOV"]
  spec.email         = ["stas@net.utcluj.ro"]
  spec.description   = %q{Adds FTP support for mina.}
  spec.summary       = %q{Deploy to FTP using mina.}
  spec.homepage      = "https://github.com/stas/mina-ftp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mina"
  spec.add_dependency "ftp_sync"
end
