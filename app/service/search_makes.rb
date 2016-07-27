class SearchMakes
  cattr_accessor :base_url
  self.base_url = URI(ENV.fetch("WEBMOTORS_API_BASE_URL_MAKES"))

  def self.fetch
    new.tap(&:fetch)
  end

  def fetch(net_http_engine = NetHttpEngine)
    response = net_http_engine.get(self.base_url)

    results = parser(response.body)
    create_make(results)
  end

  def parser(body, json_engine = JSONEngine)
    json_engine.parse(body)
  end

  def create_make(results)
    results.each { |params| build_make(params) unless verify_make(params) }
  end

  def verify_make(params)
    Make.where(name: params["Nome"]).present?
  end

  def build_make(params)
    Make.create(
      name: params["Nome"],
      webmotors_id: params["Id"]
    )
  end
end
