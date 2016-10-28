def format_date(date)
  I18n.localize(date, :format => "%B %d, %Y")
end

def site_title_logo
  data.settings.site_title_logo_image
  rescue NameError
    nil
end

def title(title)
  @page_title = title
end

def format_title
  separator = ' | '
  if data.settings.reverse_title
    if current_article
      current_article.title + separator + data.settings.site_title
    elsif @page_title
      @page_title + separator + data.settings.site_title
    else
      data.settings.site_title
    end
  else
    if current_article
      data.settings.site_title + separator + current_article.title
    elsif @page_title
      data.settings.site_title + separator + @page_title
    else
      data.settings.site_title
    end
  end
end

def page_description
  if current_article && current_article.summary(100)
    description = current_article.summary
  elsif @page_title
    description = @page_title + ' page of ' + data.settings.site_title
  else
    description = data.settings.site_description
  end
  # remove html tags
  description.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '').gsub(/[\r\n]/, ' ')
end

def analytics_account
  google_analytics_account
  rescue NameError
    nil
end

def build_categories(articles)
  categories = []
  articles.each do |article|
    # category = article.metadata[:page]['category']
    category = article.data.category
    categories.push(category) unless categories.include? category
  end
  categories
end

def category_name(category_slug)
  data.categories[category_slug]['name']
end

def article_category_slug(article)
  article.data.category.present? ? article.data.category.to_s : 'unknown'
end

def article_category_name(article)
  category_name(article_category_slug(article))
end
