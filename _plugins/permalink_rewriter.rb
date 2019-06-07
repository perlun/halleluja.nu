module Jekyll
  module Utils
    alias_method :slugify_real, :slugify

    # Local override of slugify method, to support åäö -> aao
    # conversions; in other words, replacing umlauts with their ASCII-
    # safe counterparts.
    def slugify(string, mode: nil, cased: false)
      sanitized_string = ascii_sanitize(string)
      slugify_real(sanitized_string, mode: mode, cased: cased)
    end

    def ascii_sanitize(s)
      result = s.dup
      result.gsub!(/å/, 'a')
      result.gsub!(/ä/, 'a')
      result.gsub!(/ö/, 'o')
      result.gsub!(' ', '-')
      result
    end
  end

  # By default, permalinks have this format:
  # /undervisning%20fr%C3%A5n%20bibeln/2017/05/19/simul-justus-et-peccator-samtidigt-syndare-och-rattfardig/
  #
  # The generator below changes this to be
  #
  #
  # Inspired by http://stackoverflow.com/a/17206081/227779
  class PermalinkRewriter < Generator
    safe true
    priority :low

    def generate(site)
      site.posts.docs.each do |item|
        item.data['permalink'] = '/' + [
          Utils.ascii_sanitize(item.data.fetch('categories').join('/').downcase),
          item.date.year,
          item.date.month,
          item.date.day,
          item.data.fetch('slug')
        ].join('/')
      end
    end
  end
end
