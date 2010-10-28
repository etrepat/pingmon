require 'ftools'

module PingMon
  class ConfigFileNotFound < StandardError
  end

  class Config
    def initialize(config_file=PingMon::DEFAULT_CONFIG_FILE)
      @config_file = config_file
      @loaded = false
    end

    attr_accessor :config_file

    def load
      raise ConfigFileNotFound.new("Configuration file '#{config_file}' could not be found!") unless File.exists?(config_file)

      PingMon.log << "Loading configuration from '#{@config_file}'" if PingMon.log

      text = ERB.new(File.read(config_file)).result
      hash = YAML.load(text)

      base_config = (hash.symbolize_keys[:config]).stringify_keys
      base_config.keys.each do |key|
        instance_variable_set("@#{key}", base_config[key])
        self.class.class_eval do
          define_method(key.to_sym) { instance_variable_get("@#{key}") }
        end
      end
      @loaded = true

      self
    end

    def loaded?
      @loaded
    end

    def self.build_config(where=PingMon::DEFAULT_CONFIG_FILE)
      from = File.dirname(__FILE__) + '/../../config/pingmon.yml'
      File.copy(File.expand_path(from), where)
      PingMon.Log << "Created configuration file '#{where}'." if PingMon.log
    end
  end
end

