class HTMLSanitizer
  def sanitize(text)
    text = Sanitize.clean text, config
  end


  private

  def config
    settings = {
      :elements => ['a', 'p', 'br', 'code', 'span', 'b', 'strong', 'i', 'em', 'h2', 'h3', 'h4', 'hr', 'img', 'li', 'ol', 'ul', 's', 'sub', 'sup', 'table', 'tbody', 'tr', 'th', 'td', 'tt'],
      :attributes => {
        'a' => ['href', 'title'],
        'img' => ['src', 'alt']
      },
      :protocols => {
        'a'   => {'href' => ['http', 'https', 'mailto', :relative]},
        'img' => {'src'  => ['http', 'https', :relative]}
      }
    }
  end
end