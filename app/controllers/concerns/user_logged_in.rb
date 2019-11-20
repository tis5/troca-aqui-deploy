require 'rest-client'
require 'json'
module UserLoggedIn
    urls = %w[
     troca-aqui-api-e7p5jefkcq-uc.a.run.app
     localhost:3000
      ]
    urls.each do |url|
      resp = RestClient.get "#{url}/logged_in"
      resp_json = JSON.parse(resp.body)

      if resp_json["logged_in"]!=false
        puts resp_json["logged_in"]
        return resp_json["logged_in"]
      end
    end

end
