module PingMon
  class Config
    def initialize(config_file='config.yml')
      @config_file = config_file
      @loaded = false
    end

    attr_accessor :config_file

    def load
      raise "Configuration file '#{config_file}' could not be found!" unless File.exists?(config_file)

      # TODO: add logger and remove puts
      puts "Loading configuration from '#{@config_file}'"

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
  end
end

