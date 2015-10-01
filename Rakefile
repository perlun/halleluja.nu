require 'json'
require 'rake-jekyll'

Rake::Jekyll::GitDeployTask.new

task :convert do
  json_text = IO.read('backup/article.json')
  json_text = json_text
    .strip
    .delete("\r")
    .gsub("'", "\\\\'")
    .gsub("\n", '\\n')
  articles = JSON.parse(json_text, symbolize_names: true)

  puts articles.count
end
