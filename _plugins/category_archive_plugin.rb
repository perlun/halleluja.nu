# Jekyll Module to create category archive pages
# Based on code from https://github.com/shigeya/jekyll-category-archive-plugin
#
# Shigeya Suzuki, November 2013
# Copyright notice (MIT License) attached at the end of this file
#

#
# This code is based on the following works:
#   https://gist.github.com/ilkka/707909
#   https://gist.github.com/ilkka/707020
#   https://gist.github.com/nlindley/6409459
#

#
# Archive will be written as #{archive_path}/#{category_name}/index.html
# archive_path can be configured in 'path' key in 'category_archive' of
# site configuration file. 'path' is default null.
#

module Jekyll
  module CategoryArchiveUtil
    def self.archive_base(site)
      site.config['category_archive'] && site.config['category_archive']['path'] || ''
    end
  end

  # Generator class invoked from Jekyll
  class CategoryArchiveGenerator < Generator
    def generate(site)
      posts_group_by_category(site).each do |category, list|
        site.pages << CategoryArchivePage.new(site, CategoryArchiveUtil.archive_base(site), category, list)
      end
    end

    def posts_group_by_category(site)
      category_map = {}
      site.posts.docs.each { |p|
        p.data.fetch('categories').each { |c|
          (category_map[c] ||= []) << p
        }
      }
      category_map
    end
  end

  # Actual page instances. This class controls where the category
  # archive pages are written on disk.
  class CategoryArchivePage < Page
    ATTRIBUTES_FOR_LIQUID = %w[
      category,
      content
    ]

    def initialize(site, dir, category, posts)
      @site = site
      @dir = dir
      @category = category.downcase

      if site.config['category_archive'] && site.config['category_archive']['slugify']
        @category_dir_name = Utils.slugify(@category) # require sanitize here
      else
        @category_dir_name = @category
      end

      @layout =  site.config['category_archive'] && site.config['category_archive']['layout'] || 'category_archive'
      self.ext = '.html'
      self.basename = 'index'
      self.content = <<-EOS
{% for post in page.posts %}
  <li>
    <a href="{{ post.url | prepend: site.baseurl | replace: '//', '/' }}"><span>{{ post.title }}<span></a>
    ({{ post.date | date: "%Y-%m-%d" }})
  </li>
{% endfor %}
      EOS
      self.data = {
        'layout' => @layout,
        'type' => 'archive',
        'title' => "Fler artiklar i kategorin '#{@category}'",
        'posts' => posts,
        'url' => File.join('/',
                   CategoryArchiveUtil.archive_base(site),
                   @category_dir_name, 'index.html')
      }
    end

    def render(layouts, site_payload)
      payload = {
        'page' => self.to_liquid,
        'paginator' => pager.to_liquid
      }.merge(site_payload)
      do_layout(payload, layouts)
    end

    def to_liquid(attr = nil)
      self.data.merge(
        'content' => self.content,
        'category' => @category
      )
    end

    def destination(dest)
      File.join('/', dest, @dir, @category_dir_name, 'index.html')
    end

  end
end

# The MIT License (MIT)
#
# Copyright (c) 2013 Shigeya Suzuki
# Copyright (c) 2019 Per Lundberg
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
