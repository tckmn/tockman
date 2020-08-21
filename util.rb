class String
    def addclass cl; "<#{self}#{cl ? " class='#{cl}'" : ''}>"; end
    def unhtml; self.gsub /<[^>]+>/, ''; end
    def unhtml!; self.gsub! /<[^>]+>/, ''; self; end
    def oneline; self.strip.gsub "\n", ' '; end
    def oneline!; self.strip!.gsub! "\n", ' '; self; end
    def dedent; self.sub(/^\n*/, '').gsub /^#{self[/\A\s*/]}/, ''; end
    def dedent!; self.sub!(/^\n*/, '').gsub! /^#{self[/\A\s*/]}/, ''; self; end
end

class Integer
    def ordinal; "#{self}#{(self % 100) / 10 != 1 && [nil, 'st', 'nd', 'rd'][self % 10] || 'th'}"; end
end