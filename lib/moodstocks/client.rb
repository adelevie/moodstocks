module Moodstocks
  class Client

    def initialize(key, secret, version="v2")
      @key      = key
      @secret   = secret
      @version  = version
      @endpoint = "api.moodstocks.com/#{version}"
    end

    def create(path, id)
      system("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/ref/#{id}' --form image_file=@'#{path}' -X PUT")
    end

    def retrieve(path)
      system("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/search' --form image_file=@'#{path}'")
    end

    def update(path, id)
      system("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/ref/#{id}' --form image_file=@'#{path}' -X PUT")
    end

    def delete(id)
      system("curl --digest -u #{@key}:#{@secret} '#{@endpoint}/ref/#{id}' -X DELETE")
    end

  end
end
