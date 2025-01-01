#!/usr/bin/env ruby

require 'cgi'
require 'fileutils'
require 'optparse'
require 'ostruct'
require 'set'
require 'time'
require_relative 'special'
require_relative 'util'

class Props
    def initialize fname
        @fname = fname
        @section = fname.split(?/)[0]
        @style = Set.new
        @script = Set.new
        @mainclass = nil
        @title = nil
        @desc = nil
        @ksh = false
        @noindex = false
        @spire = false
        @squares = false
    end

    attr_accessor *Props.new('').instance_variables.map{|x| x[1..-1]}
    def [] k; self.send k; end
    def []= k, v; self.send "#{k}=", v; end
    def merge! props; props.each{|k,v| self[k] = v }; end

    def style= v
        case v
        when Set   then @style = v
        when Array then @style = v.to_set
        else            @style = Set[v]
        end
    end
end

puzzlink = false
OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"
    opts.on '-p', '--[no-]puzzlink', 'scrape images from puzz.link' do |p|
        puzzlink = true
    end
    opts.on '-h', '--help', 'show help' do
        puts opts
        exit
    end
end.parse!

$template = special File.read('pre/template.html'), Props.new('')
$target = 'tckmn.github.io'

def go path, ext='html', &blk
    Dir.entries(path).each do |fname|
        next if fname == 'template.html' || File.directory?("#{path}/#{fname}") || fname.split('.')[1] != ext
        full, name = "#{path}/#{fname}", fname.split('.')[0]
        blk.call File.read(full), name
    end
end

$rendered = Set.new
def render fname, html, **props
    fname.sub! 'index', ''
    fname.gsub! ?_, ?/
    fname.gsub! /^\/+|\/+$/, ''

    flags = Props.new fname
    flags.merge! props
    html = special html, flags
    html = special_post html, flags

    puts "WARNING: #{fname} lacks title" unless flags.title || fname.empty?
    puts "WARNING: #{fname} lacks desc" unless flags.desc

    html = $template
        .sub(/(href='\/#{flags.section}')(?: class='([^']*)')?/, '\1 class=\'active \2\'')
        .sub('<!--*-->', html)
        .gsub('<!--t-->', "#{flags.title}#{flags.title && ' - '}")
        .gsub('<!--t*-->', (flags.title || '').split(' - ')[0] || '')
        .gsub('<!--s-->', flags.script.sort.map{|x|"<script src='/js/#{$js[x]}.js'></script>"}.join + (['global'] + flags.style.sort).map{|x| "<link rel='stylesheet' href='/css/#{$css[x]}.css'>"}.join)
        .gsub('<!--d-->', CGI.escapeHTML((flags.desc || "The #{flags.title} page on Andy Tockman's website.").unhtml.oneline))
        .gsub('<!--u-->', fname)
        .sub('<main>', 'main'.addclass(flags.mainclass))
        .sub(/<div id='subheader'>.*?<\/div>/m, flags.ksh ? '' : '\0')

    fname = "#{$target}/#{fname}#{flags.noindex ? '.html' : '/index.html'}"
    FileUtils.mkdir_p fname.sub(/[^\/]*$/, '')
    File.write fname, html
    $rendered.add fname.gsub(/\/+/, ?/)
end

def makerss fname, title, link, desc, items, ifunc
    $rendered.add "#{$target}/#{fname}"
    File.open("#{$target}/#{fname}", 'w') do |f|
        f.puts <<~x
        <rss version="2.0">
            <channel>
                <title>#{title}</title>
                <link>#{link}</link>
                <description>#{desc}</description>
                <language>en</language>
        #{items.map(&ifunc).map do |ititle, ilink, idesc, idate| <<~y
            <item>
                <title>#{ititle.encode :xml => :text}</title>
                <link>#{ilink}</link>
                <description>#{idesc.encode :xml => :text}</description>
                <pubDate>#{Time.parse(idate).rfc2822}</pubDate>
                <guid>#{ilink}</guid>
            </item>
        y
        end * "\n"}
            </channel>
        </rss>
        x
    end
end

$css = {}
FileUtils.remove_dir "#{$target}/css"
FileUtils.mkdir "#{$target}/css"
go('pre/sass', 'sass') do |txt, name|
    sass txt, name
end

$js = {}
FileUtils.remove_dir "#{$target}/js"
FileUtils.mkdir "#{$target}/js"
go('pre/js', 'js') do |txt, name|
    js txt, name
end

go('pre') do |html, name|
    render name, html
end

go('pre', 'md') do |md, name|
    render name, cmark(md)
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
    "<div class='hsup'>#{before}<span>#{post[:date].split[0]}</span></div><div class='hsub'><span class='len len#{lendesc.split.join}'><span>#{lendesc}</span> (#{post[:words]/10*10} words)</span> #{post[:tags].map{|x|blogtag x}*''}</div>#{post[:excerpt] if full}"
end
def blogshtml pa
    pa.sort_by{|x|x[:date]}.reverse.map{|x|bloghtml x, true}.join
end

posts = []
by_tag = Hash.new{|h,k| h[k]=[]}
go('pre/blog', 'md') do |html, name|
    real = html.lines.drop(4).join

    date, tags = html.lines.first.chomp.split ' // '
    tags = tags.split ', '
    title = html.lines[2][2..-1].chomp
    excerpt = cmark real.sub(/\[EXCERPT\].*/m, ''), "/blog/#{name}"
    content = cmark real.sub('[EXCERPT]', ''), "/blog/#{name}"
    words = content.unhtml.split.size

    post = { name:, date:, tags:, title:, excerpt:, content:, words: }

    unless tags.include? 'draft'
        posts.push post
        tags.each do |tag| by_tag[tag].push post; end
    end

    render "blog/#{name}", "#{bloghtml post, false}\n#{content}\n.comments #{name}", title: title, desc: excerpt.unhtml.oneline
end

# index pages
hint = "<p style='margin-bottom:-10px'>Click a tag to filter by posts with that tag. <a href='/blog.xml' style='float:right'><img src='/img/rss.png'></a></p>"
render 'blog', hint+blogshtml(posts), title: 'Blog', desc: 'A blog containing various ramblings on various topics.', style: 'blogindex'
by_tag.each do |k,v|
    head = "<h1>posts tagged #{blogtag k}<span class='all'><a href='/blog'>view all »</a></span></h1><hr class='c'>"
    render "blog/#{k.gsub ' ', ?-}", head+blogshtml(v), title: "Posts tagged #{k}", desc: "All blog posts with the #{k} tag.", style: 'blogindex'
end

# rss
makerss('blog.xml',
        'Blog - Andy Tockman',
        'https://tck.mn/blog/',
        "Andy Tockman's blog",
        posts.sort_by{|p| p[:date]}.reverse,
        ->p{[p[:title],
             "https://tck.mn/blog/#{p[:name]}",
             p[:excerpt].gsub(/<[^>]*>/, '').chomp,
             p[:date]]})

# puzzles
def listtypes types
  types.chunk{|x|x}.map{|type,a|"#{type} x#{a.size}".sub ' x1',''}*', '
end
$logic = open('pre/puzzle/logic').read.chomp.split("\n\n").map.with_index do |pset,i|
    header, *puzs, desc = pset.lines
    date, *subtitle = header.chomp.split ' // '
    puzs.map! do |puz|
        diff, link = puz.split
        { diff: diff, link: link, type: link.split(??)[1].split(?/)[0] }
    end
    desc.sub! /\{\{(.*?)\}\}/, '\1'
    { id: i+1, date: date, puzs: puzs, desc: desc, shortdesc: $1 || desc,
      title: "Puzzles ##{i+1} (#{listtypes puzs.map{|puz| puz[:type]}})",
      subtitle: subtitle[0] }
end

$logic.each do |p|
    html = <<~x
    <h1>#{p[:title]}</h1>
    <p id='ldat'>posted #{p[:date]}</p>
    <p><a href='..'>« back</a></p>
    #{p[:subtitle] && "<p><strong>#{p[:subtitle]}</strong></p>"}
    <p>#{p[:desc]}</p>
    <p><i>(You can click the images to solve these puzzles with an online interface.)</i></p>
    #{p[:puzs].map.with_index{|puz,i|
        imgurl = "/img/logic-#{p[:id]}-#{i}.png"

        # generate puzzle images if requested via cmd line
        puts %x{
        chromium --headless --dump-dom --virtual-time-budget=10000 "#{puz[:link]}" 2>/dev/null \
            | tr -d $'\n' \
            | grep -o '<svg.*</svg>' \
            | convert - "#{$target+imgurl}"
        echo "wrote output at #{$target+imgurl}"
        } if puzzlink && !File.exists?($target+imgurl)

        <<~y
        <div class='lpuz'>
            <p>#{puz[:type]}, difficulty #{?★*puz[:diff].to_i}</p>
            <p><a href='#{puz[:link]}'><img src='#{imgurl}'></a></p>
        </div>
        y
    }*''}
    x
    render "puzzle/logic/#{p[:id]}", html,
        title: p[:title],
        desc: "Solve my #{p[:id].ordinal} set of logic puzzles#{", #{p[:subtitle]}" if p[:subtitle]} #{p[:title].split[2..-1].join ' '}.",
        style: 'logicpuz'
end

makerss('logic.xml',
        'Logic puzzles - Andy Tockman',
        'https://tck.mn/puzzle/logic/',
        "Logic puzzles by @tckmn",
        $logic,
        ->p{[p[:title],
             "https://tck.mn/puzzle/logic/#{p[:id]}",
             p[:puzs].map{|puz| puz[:link]}*"\n" + "\n\n" + p[:desc].gsub(/<[^>]*>/, ''),
             p[:date]]})

go('pre/squares') do |html, name|
    render "squares/#{name}", html, squares: true
end

go('pre/atomic') do |html, name|
    render "atomicguide/#{name}", html, section: 'boardgame'
end

go('pre/puzzle') do |html, name|
    render "puzzle/#{name}", html
end

if nil
    Dir.glob('tckmn.github.io/**/*').each do |f|
        if File.file?(f) && !$rendered.include?(f)
            p f
        end
    end
end
