#!/usr/bin/env ruby

require 'cgi'
require 'fileutils'
require 'optparse'
require 'ostruct'
require 'set'
require 'time'
require_relative 'special'
require_relative 'util'

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

$template = special File.read('pre/template.html'), {}
$target = 'tckmn.github.io'

def go path, ext='html', &blk
    Dir.entries(path).each do |fname|
        next if fname == 'template.html' || File.directory?("#{path}/#{fname}") || fname.split('.')[1] != ext
        full, name = "#{path}/#{fname}", fname.split('.')[0]
        blk.call File.read(full), name
    end
end

$rendered = Set.new
def render fname, html, flags=OpenStruct.new
    fname.sub!('index', '').gsub!(?_, ?/)

    flags = OpenStruct.new flags if Hash === flags
    flags.fname = fname
    html = special html, flags

    puts "WARNING: #{fname} lacks title" unless flags.title || fname.empty?
    puts "WARNING: #{fname} lacks desc" unless flags.desc

    html = $template
        .sub(/(href='\/#{flags.section || fname.split(?/)[0]}')(?: class='([^']*)')?/, '\1 class=\'active \2\'')
        .sub('<!--*-->', html)
        .gsub('<!--t-->', "#{flags.title}#{flags.title && ' - '}")
        .gsub('<!--t*-->', (flags.title || '').split(' - ')[0] || '')
        .gsub('<!--s-->', (flags.script || []).map{|x|"<script src='/js/#{x}.js'></script>"}.join + ((flags.style || []) + [$css['global']]).map{|x| "<link rel='stylesheet' href='/css/#{x}.css'>"}.join)
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
    $css[name] = sass txt, name
end

go('pre') do |html, name|
    render name, html, {ksh: name == 'index', noindex: name == '404'}
end

def blogtag tag
    "<a class='tag' href='/blog/#{tag.sub ' ', ?-}'><span class='tag'>#{tag}</span></a>"
end
def bloghtml post, full=true
    sub = "<div class='hsub'>#{post[:date]} #{post[:tags].map{|x|blogtag x}*''}</div>"
    full ? "<h2><a href='/blog/#{post[:name]}'>#{post[:title]}</a></h2>#{sub}#{post[:excerpt]}" : sub
end
def blogshtml pa
    pa.sort_by{|x|x[:date]}.reverse.map{|x|bloghtml x}.join
end

posts = []
by_tag = Hash.new{|h,k| h[k]=[]}
go('pre/blog', 'md') do |html, name|
    content = cmark html.lines.drop(2).join.sub('[EXCERPT]', ''), "/blog/#{name}"
    date, tags = html.lines.first.chomp.split ' // '
    tags = tags.split ', '
    title = html.lines[2][2..-1].chomp
    excerpt = cmark html.lines.drop(4).join.sub(/\[EXCERPT\].*/m, ''), "/blog/#{name}"

    post = { name: name, date: date, tags: tags, title: title, excerpt: excerpt }

    unless tags.include? 'draft'
        posts.push post
        tags.each do |tag| by_tag[tag].push post; end
    end

    render "blog/#{name}", content.sub('</h1>', "\\0#{bloghtml post, false}") + "\n.comments #{name}", {title: title, desc: excerpt.unhtml.oneline}
end

# index pages
hint = "<p style='margin-bottom:-10px'>Click a tag to filter by posts with that tag. <a href='/blog.xml' style='float:right'><img src='/img/rss.png'></a></p>"
render 'blog', hint+blogshtml(posts), {title: 'Blog', desc: 'A blog containing various ramblings on various topics.', style: [$css['blogindex']]}
by_tag.each do |k,v|
    head = "<h1>posts tagged #{blogtag k}<span class='all'><a href='/blog'>view all »</a></span></h1><hr class='c'>"
    render "blog/#{k.sub ' ', ?-}", head+blogshtml(v), {title: "Posts tagged #{k}", desc: "All blog posts with the #{k} tag.", style: [$css['blogindex']]}
end

# rss
makerss('blog.xml',
        'Blog - Andy Tockman',
        'https://tck.mn/blog/',
        "Andy Tockman's blog",
        posts,
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
    render "puzzle/logic/#{p[:id]}", html, {
        title: p[:title],
        desc: "Solve my #{p[:id].ordinal} set of logic puzzles#{", #{p[:subtitle]}" if p[:subtitle]} #{p[:title].split[2..-1].join ' '}.",
        style: [$css['logicpuz']]
    }
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

def repl x, from, to
    to.flat_map{|y| opts x.sub(from, y)}
end
def opts x
    return repl x, '(dir)', ['', 'in', 'out', "(d\0ir)"] if x.include? '(dir)'
    return repl x, '(fract)', ['', '1/4', '1/2', '3/4'] if x.include? '(fract)'
    return repl x, /\(([^)]+)\)/, ['', $1] if x =~ /\(([^)]+)\)/
    [x]
end
def snorm x
    x.sub(/ (CONCEPT|FORMATION)$/, '').downcase.gsub(/[^a-z0-9&]/, '')
end
@slist = File.readlines('squares').flat_map{|x|
    a,b = x.chomp.split "\t"
    opts(b).map{|y| [snorm(y), a.upcase.sub(/MAINSTREAM|PLUS/, 'plus')]}
}.each_with_object({}) {|(k,v), h| h[k] = v unless h[k]}
def trysub x, from, to
    x =~ from ? getlvl(x.sub(from, to)) : nil
end
def atleast x, y
    'C4 C3B C3A C2 C1 A2 A1 plus'.split.find{|z| z==x || z==y}
end
def getlvl x
    ret = @slist[snorm x]; return ret if ret
    ret = trysub x, /^central /, ''; return ret if ret
    ret = trysub x, /^tandem /, ''; return atleast('C2', ret) if ret
    ret = trysub x, /^beaus /, ''; return atleast('A1', ret) if ret
    ret = trysub x, /^couples twosome /, ''; return atleast('C3A', ret) if ret
    ret = trysub x, /^finish /, ''; return atleast('C1', ret) if ret
    ret = trysub x, / to a wave$/, ''; return atleast('C1', ret) if ret
    'x'
end
def squares html
    html.gsub(/@([^@]+)@/) {
        call = $1
        lvl = getlvl CGI.unescapeHTML call
        if call.include? ?|
            lvl, call = call.split ?|
        end
        p call if lvl == 'x'
        "<span class='call #{lvl[0].downcase}'><span class='c1'>#{lvl}</span><span class='c2'>#{call}</span></span>"
    }
end

go('pre/squares') do |html, name|
    render "squares/#{name}", squares(html), {style: [$css['squares']]}
end

go('pre/atomic') do |html, name|
    render "atomicguide/#{name}", html, {section: 'boardgame'}
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
