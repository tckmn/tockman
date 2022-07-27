require 'open3'

class String
    def addclass cl; "<#{self}#{cl ? " class='#{cl}'" : ''}>"; end
    def unhtml; self.gsub /<[^>]+>/, ''; end
    def unhtml!; self.gsub! /<[^>]+>/, ''; self; end
    def oneline; self.strip.gsub "\n", ' '; end
    def oneline!; self.strip!.gsub! "\n", ' '; self; end
    def dedent; self.sub(/^\n*/, '').gsub /^#{self[/\A\s*/]}/, ''; end
    def dedent!; self.sub!(/^\n*/, '').gsub! /^#{self[/\A\s*/]}/, ''; self; end
    def rawify; self.gsub('&lt;', ?<).gsub('&gt;', ?>).gsub('&amp;', ?&); end
    def rawify!; self.gsub!('&lt;', ?<).gsub!('&gt;', ?>).gsub!('&amp;', ?&); self; end
end

class Integer
    def ordinal; "#{self}#{(self % 100) / 10 != 1 && [nil, 'st', 'nd', 'rd'][self % 10] || 'th'}"; end
end

def cmark s, base
    Open3
        .capture2('cmark --unsafe', :stdin_data=>s)[0]
        .gsub(/^[<>\w]+\\raw\s+(.*?)<\/[<>\/\w]+$/m){$1.rawify}
        .gsub(/^[<>\w]+\\rawp\s+(.*?)<\/[<>\/\w]+$/m){"<p>\n#{$1.rawify}\n</p>"}
        .gsub('<img src="=', "<img src=\"#{base}/")
        .gsub(/(<h.)(>[^<]+) #(\w+)(?=<\/h)/, '\1 id="\3"\2')
end
