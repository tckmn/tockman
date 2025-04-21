require 'sassc'
require 'open3'

class String
    def addclass cl; "<#{self}#{cl ? " class='#{cl}'" : ''}>"; end
    def unhtml; self.gsub /<[^>]+>/, ''; end
    def unhtml!; self.gsub! /<[^>]+>/, ''; self; end
    def oneline; self.strip.gsub "\n", ' '; end
    def oneline!; self.strip!.gsub! "\n", ' '; self; end
    def dedent; self.sub(/^\n*/, '').gsub /^#{self.lines.filter{|x|x.size>1}.map{|x|x[/^\s*/]}.min}/, ''; end
    def dedent!; self.sub!(/^\n*/, '').gsub! /^#{self.lines.filter{|x|x.size>1}.map{|x|x[/^\s*/]}.min}/, ''; self; end
end

class Integer
    def ordinal; "#{self}#{(self % 100) / 10 != 1 && [nil, 'st', 'nd', 'rd'][self % 10] || 'th'}"; end
end

# TODO eliminate repetition in special#special
def cmark s, base=nil
    specstr = 'ldskjvwe'
    specid = -1
    speclist = []
    s.gsub! /(^[ \t]*)\.(\w+)([ +])(!)?{{(.*?)\s*}}$/m do
        speclist.push $&
        "#$1<!--#{specstr}#{specid+=1}-->"
    end
    s.gsub! /(^[ \t]*)\.(\w+)(?:([ +])(.*))?/ do
        speclist.push $&
        "#$1<!--#{specstr}#{specid+=1}-->"
    end
    Open3
        .capture2('cmark --unsafe', :stdin_data=>s)[0]
        .gsub(/<!--#{specstr}(\d+)-->/){ speclist[$1.to_i] }
        .gsub('<img src="=', "<img src=\"#{base}/")
        .gsub(/(<h.)(>[^<]+) #(\w+)(?=<\/h)/, '\1 id="\3"\2')
        .gsub(/<p>!small<\/p>\s*<([uo])l>/, '<\1l class="small">')
end

def katex s, display=false
    Open3.capture2('npx katex -T' + (display ? ' -d' : ''), :stdin_data=>s)[0]
end

def decache s, name, cache, ext
    puts "WARNING: #{cache[name]}.#{ext} already cached" if cache.include? name
    cache[name] = ext + ?/ + name + ?- + crc(s)
    fname = "#{$target}/#{cache[name]}.#{ext}"
    $rendered.add fname
    File.write fname, s
    name
end

def sass s, name
    decache SassC::Engine.new(s, style: :compressed).render, name, $css, 'css'
end

def js s, name
    decache s, name, $js, 'js'
end

@tbl = [0]*256
-> {
    x = 0x80000000
    (0..7).each do |i|
        x = ((x << 1) ^ (x & 0x80000000 == 0 ? 0 : 0x04C11DB7)) & 0xffffffff
        (0...2**i).each do |j|
            @tbl[2**i+j] = x ^ @tbl[j]
        end
    end
}[]

def crc s
    ret = 0
    itob = ->n { n == 0 ? [] : [n & 0xff] + itob[n >> 8] }
    (s.bytes + itob[s.size]).each do |ch|
        ret = (ret << 8) ^ @tbl[((ret >> 24) ^ ch.ord) & 0xff]
    end
    (~ret & 0xffffffff).to_s(16).rjust(8, ?0)
end

def blogtag tag
    "<a class='tag' href='/blog/#{tag.gsub ' ', ?-}'><span class='tag'>#{tag}</span></a>"
end
def bloghtml post, full
    before = if full
                 "<h2><a href='/blog/#{post[:name]}'>#{post[:title]}</a></h2>"
             else
                 "<h1>#{post[:title]}</h1>"
             end
    lendesc = case post[:words]
              when 3000.. then 'very long'
              when 2000.. then 'long'
              when 1000.. then 'medium'
              when 400.. then 'short'
              else 'very short'
              end
    cls = full ? ' excerpt' : ''
    "<div class='hsup#{cls}'>#{before}<span>#{post[:date].split[0]}</span></div><div class='hsub#{cls}'><span class='len len#{lendesc.split.join}'><span>#{lendesc}</span> (#{post[:words]/10*10} words)</span> #{post[:tags].map{|x|blogtag x}*''}</div>#{post[:excerpt] if full}"
end
def blogshtml pa
    pa.sort_by{|x|x[:date]}.reverse.map{|x|bloghtml x, true}.join
end
