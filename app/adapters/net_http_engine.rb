class NetHttpEngine
  def self.get(uri, options = {})
    Net::HTTP.post_form(uri, options)
  end
end
