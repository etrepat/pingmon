module PingMon
  def self.version
    version_path = File.dirname(__FILE__) + "/../../VERSION"
    return File.read(version_path).chomp if File.file?(version_path)
    "0.0"
  end
end

