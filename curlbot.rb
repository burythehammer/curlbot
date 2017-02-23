require 'rest-client'

base_url_list = ["profilebooks", "serpentstail", "profilebusiness"]


def get_url(baseurl, forename, surname)
  "https://#{baseurl}.com/#{forename}-#{surname}.html"
end

def get_response_for_url
    RestClient.get(url) { |response, request, result, &block|
    case response.code
    when 200
        p "#{url} exists"
    when 404
        p "#{url} does not exist"
    else
        response.return!(request, result, &block)
    end
    }
end

url = get_url('profilebooks','Matt', 'Long')



