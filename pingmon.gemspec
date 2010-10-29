# -*- encoding: utf-8 -*-
require File.expand_path("../lib/pingmon/version", __FILE__)

Gem::Specification.new do |s|
  s.name                = %q{pingmon}
  s.version             = PingMon.version
  s.platform            = Gem::Platform::RUBY
  s.authors             = ["Estanislau Trepat"]
  s.email               = %q{estanis@etrepat.com}
  s.homepage            = "http://github.com/etrepat/pingmon"
  s.summary             = "A stupid local-networking host 'ping' monitoring tool"
  s.description         = s.summary
  s.date                = %q{2010-07-24}

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "pingmon"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.0.1"

  s.add_dependency "pony", "~> 1.0.1"
  s.add_dependency "eventmachine", "~> 0.12.10"
  s.add_dependency "rufus-scheduler", "~> 2.0.6"

  s.files               = `git ls-files`.split("\n")
  s.executables         = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path        = 'lib'
  s.default_executable  = %q{pingmon}

  s.post_install_message = %[
===========================================================================
Welcome to PingMon!

You may need to run \`pingmon build-config\` now if this is your first time
using pingmon. If not... well... you should just do... nothing ;).

Cheers!
===========================================================================
  ]
end

