class PageInfo

  attr_accessor :title, :description, :image, :duration

  def initialize(attrs = {})
    attrs.each{ |key, value| self.send("#{key}=", value)}
  end

  def self.cache_key(link)
    link.gsub(/(http[s]*:\/\/www\.|www\.|http[s]*:\/\/)/, '')
  end

  def to_json
    youtube_hash = duration.blank? ? {} : { duration: duration }
    { title: title, description: description, image: image }.merge(youtube_hash)
  end
end
