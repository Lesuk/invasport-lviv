###
# Blog settings
###

Time.zone = 'Europe/Kiev'

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"
  blog.name = "blog"
  blog.layout = "article_layout"
  # Matcher for blog source files
  blog.sources = 'articles/{year}-{month}-{day}-{title}.html'
  blog.new_article_template = File.expand_path('source/templates/article_template.erb', File.dirname(__FILE__))
  # Permalink format
  blog.permalink = '{category}/{slug}'
  blog.summary_length = 250
  blog.default_extension = '.md'
  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 5
  blog.page_link = 'page/{num}'

  blog.custom_collections = {
    category: {
      link: '/categories/{category}.html',
      template: '/category.html'
    }
  }
end

activate :blog do |blog|
  blog.name = "events"
  blog.prefix = "events"
  blog.layout = "event_layout"
  blog.sources = ":slug.html"
  blog.permalink = ":slug"
  blog.default_extension = ".md"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 5
  blog.page_link = 'page/{num}'
end

activate :blog do |blog|
  blog.name = "pages"
  blog.prefix = "pages"
  blog.layout = "page_layout"
  blog.sources = ":slug.html"
  blog.permalink = ":slug"
  blog.default_extension = ".md"
end

activate :blog do |blog|
  blog.name = "sports"
  blog.prefix = "sports"
  blog.layout = "sport_layout"
  blog.sources = ':slug.html'
  blog.permalink = ":slug"
  blog.new_article_template = File.expand_path('source/templates/sport_template.erb', File.dirname(__FILE__))
  blog.default_extension = ".md"
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

page '/feed.xml', layout: false
page '/sitemap.xml', layout: false
page '/robots.txt', layout: false

# ["tom", "dick", "harry"].each do |name|
#   proxy "/about/#{name}.html", "/about/template.html", :locals => { :person_name => name }, :ignore => true
# end

# Markdown settings
set :markdown_engine, :kramdown
set :markdown,
    layout_engine: :slim,
    tables: true,
    autolink: true,
    smartypants: true,
    input: 'GFM'


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  activate :gzip
end

configure :development do
  activate :livereload
end

# Syntax highlight settings
activate :syntax

# Activate Directory Indexes
activate :directory_indexes

activate :i18n, :langs => [:uk]

# Activate Deploy
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.branch = 'master'
  deploy.build_before = true
end

# Activate S3Sync
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'my.bucket.com' # The name of the S3 bucket you are targetting. This is globally unique.
  s3_sync.region                     = 'us-west-1'     # The AWS region for your bucket.
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
  s3_sync.delete                     = true
  s3_sync.after_build                = false
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
end


activate :external_pipeline,
  name: :webpack,
  command: build? ?
  "./node_modules/webpack/bin/webpack.js --bail -p" :
  "./node_modules/webpack/bin/webpack.js --watch -d --progress --color",
  source: ".tmp/dist",
  latency: 1
