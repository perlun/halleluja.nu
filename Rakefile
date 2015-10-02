require 'json'
require 'rake-jekyll'

Rake::Jekyll::GitDeployTask.new

categories_sv = {
  1 => 'Undervisning från bibeln',
  2 => 'Frälsning',
  3 => 'Guds kärlek',
  4 => 'Tillbedjan',
  6 => 'Världen',
  7 => 'Trons ABC'
}

desc 'Converts stuff from the previous CMS backup'
task :convert do
  json_text = IO.read('backup/article.json')
  json_text = json_text
    .strip
    .delete("\r")
    .gsub("'", "\\\\'")
    .gsub("\n", '\\n')
  articles = JSON.parse(json_text, object_class: OpenStruct)

  articles
    .select { |a| a.language == 'sv' }
    .each { |a|
      s = <<-EOF
---
layout:       post
title:        #{a.subject.sub("\n", ' ')}
date:         #{a.createdDate}
modifiedDate: #{a.modifiedDate}
categories:   #{categories_sv[a.topicID]}
language:     #{a.language}
---
#{a.introduction}

#{a.text}
EOF
      slug = a.subject
        .downcase
        .tr("\n", ' ')
        .tr(' ', '-')
        .delete(',!?')
        .tr('ÅÄÖ', 'aao')
        .tr('åäö', 'aao')
        .gsub('&mdash;', '-')
        .gsub(/-+/, '-')
      filename = "#{a.modifiedDate}-#{slug}.md"
      File.write("_posts/#{filename}", s)
    }
end
