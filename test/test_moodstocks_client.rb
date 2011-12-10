require "helper"
require "erb"

class TestMoodstocksClient < Test::Unit::TestCase

  def setup
    @settings = YAML.load(ERB.new(File.new("test/config.yml").read).result)
    @client = Moodstocks::Client.new(@settings["key"], @settings["secret"])
  end

  def test_create
    id = rand(99999) * rand(99999)
    resp = @client.create(@settings["image_1_path"], id)

    assert_equal resp["id"].to_i, id
    assert_equal resp["is_update"], false
  end

  def test_update
    id = rand(99999) * rand(99999)
    @client.create(@settings["image_1_path"], id)
    resp = @client.update(@settings["image_2_path"], id)

    assert_equal resp["id"].to_i, id
    assert_equal resp["is_update"], true
  end

  def test_search
    id = rand(99999) * rand(99999)
    @client.create(@settings["image_3_path"], id)
    found_resp = @client.search(@settings["image_3_path"])
    not_found_resp = @client.search(@settings["image_2_path"])

    assert_equal found_resp["found"], true
    assert_equal found_resp["id"].to_i, id 

    assert_equal not_found_resp["found"], false

    @client.delete(id)
  end

  def test_delete
    id = rand(99999) * rand(99999)
    @client.create(@settings["image_3_path"], id)

    before_delete_resp = @client.search(@settings["image_3_path"])
    assert_equal before_delete_resp["found"], true
    assert_equal before_delete_resp["id"].to_i, id

    @client.delete(id)
    after_delete_resp = @client.search(@settings["image_1_path"])
    assert_equal after_delete_resp["found"], false
  end

end
