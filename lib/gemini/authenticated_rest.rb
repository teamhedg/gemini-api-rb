module Gemini
  module AuthenticatedConnection

    private
    def authenticated_post(url, options = {})
      raise Gemini::InvalidAuthKeyError unless valid_key?
      body = options[:params] || {}
      nonce = new_nonce

      complete_url = "v1/#{url}"
      payload = build_payload("/v1/#{url}", options[:params], nonce)

      response = rest_connection.post do |req|
        req.url complete_url
        req.body = body.to_json
        req.options.timeout = config.rest_timeout
        req.options.open_timeout = config.rest_open_timeout
        req.headers['Content-Type'] = 'application/json'
        req.headers['Accept'] = 'application/json'

        req.headers['X-GEMINI-PAYLOAD'] = payload
        req.headers['X-GEMINI-SIGNATURE'] = sign(payload)
        req.headers['X-GEMINI-APIKEY'] = config.api_key
      end
    end

    def build_payload(url, params = {}, nonce)
      payload = {}
      payload['nonce'] = nonce
      payload['request'] = url
      payload.merge!(params) if params
      Base64.strict_encode64(payload.to_json)
    end

    def new_nonce
      (Time.now.to_f * 10_000).to_i.to_s
    end

    def sign(payload)
      OpenSSL::HMAC.hexdigest('sha384', config.secret, payload)
    end

    def valid_key?
      !! (config.api_key && config.secret)
    end
  end
end
