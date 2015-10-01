class Photo < OpenStruct

  #@Ошибка случается тогда, когда цвет thumbnailUrl "больше" цвета url
  def color_valid?
    url_color > thumbnail_color
  end

  private

  def url_color
    url[/\w*$/].hex
  end

  def thumbnail_color
    thumbnailUrl[/\w*$/].hex
  end
end
