class APIClient
  class CommunicationError < RuntimeError;
  end

  def self.retrieve_photo
    Photo.new(execute("http://jsonplaceholder.typicode.com/photos/#{rand(5000)}"))
  end

  def self.retrieve_todo_id
    json = execute("http://jsonplaceholder.typicode.com/todos", method: :post, max_retries: 3)
    json['id']
  end

  def self.execute(url, method: :get, payload: {}, max_retries: 1, timeout: 3)
    attempt = 1
    while attempt <= max_retries
      begin
        return Timeout::timeout(timeout) {
          sleep(rand(6) + 1)
          JSON.parse(RestClient::Request.execute method: method, url: url, payload: payload)
        }
      rescue Timeout::Error
        Rails.logger.debug("timeout waiting for response")
        attempt+= 1
      end
    end
    fail CommunicationError
  end
end

