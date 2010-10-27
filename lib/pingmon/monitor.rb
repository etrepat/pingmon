module PingMon
  class Monitor
    def initialize(configuration=Config.new)
      @config = configuration
    end

    def monitor
      @config.load unless @config.loaded?

      puts "Monitoring host '#{@config.host}'. Will ping every '#{@config.monitor_interval}'."
      EM.run {
        pinger = Pinger.new(@config)
        scheduler = Rufus::Scheduler::EmScheduler.start_new

        scheduler.every @config.monitor_interval do
          pinger.ping
        end
      }
    end
  end
end

