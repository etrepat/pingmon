require 'ping'
require 'erb'
require 'yaml'
require 'rubygems'
require 'pony'
require 'eventmachine'
require 'rufus/scheduler'

require File.dirname(__FILE__) + '/pingmon/config.rb'
require File.dirname(__FILE__) + '/pingmon/pinger.rb'
require File.dirname(__FILE__) + '/pingmon/monitor.rb'
require File.dirname(__FILE__) + '/pingmon/version.rb'

module PingMon
  DEFAULT_CONFIG_FILE = File.expand_path('~/.pingmon.yml')

  def self.ping(config=PingMon::Config.new)
    p = PingMon::Pinger.new(config)
    p.ping
  end

  def self.monitor(config=PingMon::Config.new)
    m = PingMon::Monitor.new(config)
    m.monitor
  end

  def self.execute_from_config(config_file=PingMon::DEFAULT_CONFIG_FILE)
    config = PingMon::Config.new(config_file).load
    raise "wrong mode" unless %w(ping monitor).include?(config.mode)

    case config.mode
      when "ping"
        self.ping(config)
      when "monitor"
        self.monitor(config)
    end
  end

  @@log = nil

  # value may be a logger instance or a string: 'stdout'|'stderr'|'an actual filename'
  def self.log= log
    @@log = create_log log
  end

  def self.log
    @@log
  end

  # Create a log that respond to << like a logger
  # param can be 'stdout', 'stderr', a string (then we will log to that file) or a logger (then we return it)
  def self.create_log param
    if param
      if param.is_a? String
        if param == 'stdout'
          stdout_logger = Class.new do
            def << obj
              STDOUT.puts obj
            end
          end
          stdout_logger.new
        elsif param == 'stderr'
          stderr_logger = Class.new do
            def << obj
              STDERR.puts obj
            end
          end
          stderr_logger.new
        else
          file_logger = Class.new do
            attr_writer :target_file

            def << obj
              File.open(@target_file, 'a') { |f| f.puts obj }
            end
          end
          logger = file_logger.new
          logger.target_file = param
          logger
        end
      else
        param
      end
    end
  end

end

