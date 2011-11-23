require "helper"
require "erb"

class TestMoodstocksClient < Test::Unit::TestCase
  def setup
    @settings = YAML.load(ERB.new(File.new("test/config.yml").read).result)
    @client = Moodstocks::Client.new(@settings["key"], @settings["secret"])
    @id = rand(99999)
  end

  def test_create
    @client.create(@settings["image_1_path"], @id)
  end
end
