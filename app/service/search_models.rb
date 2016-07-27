class SearchModels
  cattr_accessor :base_url
  self.base_url = URI(ENV.fetch("WEBMOTORS_API_BASE_URL_MODELS"))

  def initialize(webmotors_make_id)
    @webmotors_make_id = webmotors_make_id
  end

  def self.fetch(webmotors_make_id)
    new(webmotors_make_id).tap(&:fetch)
  end

  def fetch(net_http_engine = NetHttpEngine)
    response = net_http_engine.get(self.base_url, { marca: webmotors_make_id })

    results = parser(response.body)
    create_models(results)
  end

  def parser(body, json_engine = JSONEngine)
    json_engine.parse(body)
  end

  def create_models(results)
    results.each { |params| build_model(params) unless verify_model(params) }
  end

  def verify_model(params)
    Model.where(name: params["Nome"], make_id: make_id).present?
  end

  def make_id
    make.id
  end

  def make
    Make.find_by(webmotors_id: webmotors_make_id)
  end

  def build_model(params)
    Model.create(
      make_id: make_id,
      name: params["Nome"]
    )
  end

  attr_reader :webmotors_make_id
end
