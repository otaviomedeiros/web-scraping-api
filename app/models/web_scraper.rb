class WebScraper

  def initialize(html_page)
    @page = Nokogiri::HTML(html_page)
  end

  def page_info
    page_info = PageInfo.new
    page_info.title = parse(:title)
    page_info.description = parse(:description)
    page_info.image = parse(:image)
    page_info.duration = parse(:duration)

    page_info
  end

  private

  def parse(name)
    send("parse_#{name}").try(:text).try(:strip) || ''
  end

  def parse_title
    find_tag_content('title') ||
    find_attr_content('meta[name=title]') ||
    find_attr_content("meta[property='og:title']")
  end

  def parse_description
    find_attr_content('meta[name=description]') ||
    find_attr_content("meta[property='og:description']")
  end

  def parse_image
    find_attr_content("meta[property='og:image']") ||
    find_attr_content("meta[property='twitter:image']")
  end

  def parse_duration
    find_attr_content("meta[itemprop=duration]")
  end

  def find_tag_content(tag_name)
    @page.css(tag_name)[0]
  end

  def find_attr_content(attr)
    @page.css(attr)[0].try(:attribute, 'content')
  end
end
