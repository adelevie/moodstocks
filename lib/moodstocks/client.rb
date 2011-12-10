module Moodstocks

  class Client

    def initialize(key, secret, version="v2")
      @key      = key
      @secret   = secret
      @version  = version
      @endpoint = "api.moodstocks.com/#{version}"

      @ep = "v2"
    end

    def raw_request(cmd)
      resp = Open3.popen3(cmd) do |input, output, error|
        output.gets
      end
      JSON.parse(resp)
    end

    def create(path, id)
      raw_request("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/ref/#{id}' --form image_file=@'#{path}' -X PUT")
    end

    def search(path)
      puts "WARNING: #search is unstable and probably will not work"
      raw_request("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/search' --form image_file=@'#{path}'")
    end

    def update(path, id)
      raw_request("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/ref/#{id}' --form image_file=@'#{path}' -X PUT")
    end

    def delete(id)
      raw_request("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/ref/#{id}' -X DELETE")
    end

  end
end
