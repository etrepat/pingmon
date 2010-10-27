require 'rubygems'
require 'ping'
require 'pony'
require 'erb'
require 'yaml'
require 'eventmachine'
require 'rufus/scheduler'

require File.dirname(__FILE__) + '/pingmon/config.rb'
require File.dirname(__FILE__) + '/pingmon/pinger.rb'
require File.dirname(__FILE__) + '/pingmon/monitor.rb'

module PingMon
  def self.ping(config=PingMon::Config.new)
    p = PingMon::Pinger.new(config)
    p.ping
  end

  def self.monitor(config=PingMon::Config.new)
    m = PingMon::Monitor.new(config)
    m.monitor
  end

  def self.execute_from_config(config_file='config.yml')
    config = PingMon::Config.new(config_file).load
    raise "wrong mode" unless %w(ping monitor).include?(config.mode)

    case config.mode
      when "ping"
        self.ping(config)
      when "monitor"
        self.monitor(config)
    end
  end
end

