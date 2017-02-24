require 'rest-client'

def get_url(baseurl, name)
  "http://#{baseurl}.com/#{name}.html"
end

def url_response_code(url)
  begin
    response = RestClient::Request.execute(method: :head, url: url, verify_ssl: false)
    return response.code
  rescue RestClient::ExceptionWithResponse => err
    return err.response.code
  end
end

def get_url_codes(namelist, base_url_list)
  url_codes = []

  namelist.each do |name|
    base_url_list.each do |base_url|
      url = get_url(base_url, name)
      code = url_response_code(url)
      p "#{url} returned #{code}"
      url_codes.push("#{url}: #{code}")
    end
  end

  url_codes
end

def parse_names(filepath)
  names = File.read(filepath).downcase.lines.map(&:chomp)
  names.map do |name|
    name.tr!(' ', '-') if name.include? ' '
  end
end

def parse_base_urls(filepath)
  File.read(filepath).downcase.lines.map(&:chomp)
end

namelist = parse_names('names.txt')
base_url_list = parse_base_urls('base_urls.txt')
urlcodes = get_url_codes(namelist, base_url_list)

urlcodes.each {|r| p r}
