module PingMon
  class Pinger
    def self.ping(host)
      ::Ping.pingecho(host)
    end

    def initialize(configuration=Config.new)
      @config = configuration
    end

    def ping
      @config.load unless @config.loaded?

      puts "[#{Time.now}] - Pinging host '#{@config.host}'."
      result = PingMon::Pinger.ping(@config.host)
      unless result
        puts "[#{Time.now}] - '#{@config.host}' appears to be: DOWN. Sending notification."
        notify_down_status if @config.notify_when_down
      else
        puts "[#{Time.now}] - '#{@config.host}' appears to be: UP."
      end

      result
    end

    def host
      @config.host if @config.loaded?
    end

    protected
      def notify_down_status
        params = build_pony_params_hash
        Pony.mail(params)
      end

      def build_pony_params_hash
        hash = {
          :to => @config.notify_to,
          :from => @config.from_address,
          :subject => "Monitored host '#{@config.host}' seems to be down",
          :body => "Ping to #{@config.host} failed at #{Time.now}!",
          :via => @config.transport
        }
        hash[:via_options] = @config.smtp_options.symbolize_keys if hash[:via] == :smtp
        return hash
      end
  end
end

