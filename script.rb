#!/usr/bin/env ruby

require 'cgi'
require 'fileutils'
require 'optparse'
require 'ostruct'
require 'time'
require_relative 'special'

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

$template = special(File.read 'pre/template.html')[0]
$target = 'tckmn.github.io'

def go path, ext='html', &blk
    Dir.entries(path).each do |fname|
        next if fname == 'template.html' || File.directory?("#{path}/#{fname}") || fname.split('.')[1] != ext
        full, name = "#{path}/#{fname}", fname.split('.')[0]
        blk.call File.read(full), full, name, name.sub('index', '').gsub('_', '/')
    end
end

def addclass tag, cl; "<#{tag}#{cl ? " class='#{cl}'" : ''}>"; end

def render fname, html, name, active, flags={}
    html, props = special html
    flags = OpenStruct.new(flags.merge props)

    puts fname unless flags.desc
    html = $template
        .sub(/(href='\/#{active}')(?: class='([^']*)')?/, '\1 class=\'active \2\'')
        .sub('<!--*-->', html)
        .gsub('<!--t-->', "#{flags.title}#{flags.title && ' - '}")
        .gsub('<!--t*-->', (flags.title || '').split(' - ')[0] || '')
        .gsub('<!--s-->', (flags.script || []).map{|x|"<script src='/js/#{x}.js'></script>"}.join)
        .gsub('<!--c-->', "#{name}.css")
        .gsub('<!--d-->', CGI.escapeHTML((flags.desc || "The #{flags.title} page on Andy Tockman's website.").gsub(/<[^>]+>/, '')))
        .gsub('<!--u-->', fname)
        .sub('<main>', addclass('main', flags.mainclass))
        .sub(/<div id='subheader'>.*?<\/div>/m, flags[:ksh] ? '' : '\0')

    fname = "#{$target}/#{fname}#{flags[:noindex] ? '.html' : '/index.html'}"
    FileUtils.mkdir_p fname.sub(/[^\/]*$/, '')
    File.write fname, html
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

go('pre') do |html, full, name, name2|
    render name2, html, name, name2, {ksh: name == 'index', noindex: name == '404'}
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
go('pre/blog', 'md') do |html, full, name|
    content = `cmark --unsafe #{full}`.lines.drop(1).join
    date, tags = html.lines.first.chomp.split(nil, 2)
    tags = tags.split ?,
    title = content.split(?<)[1][3..-1]

    post = {
        name: name, date: date, tags: tags, title: title,
        excerpt: `tail -n+5 #{full} | sed -n '/<!--\\*-->/{q};p' | cmark`
    }
    posts.push post
    tags.each do |tag| by_tag[tag].push post; end

    render "blog/#{name}", content.sub('</h1>', "\\0#{bloghtml post, false}"), name, 'blog', {title: title, mainclass: 'pind'}
end

# index pages
hint = "<p class='ni' style='margin-bottom:-10px'>Click a tag to filter by posts with that tag. <a href='/blog.xml' style='float:right'><img src='/img/rss.png'></a></p>"
render 'blog', hint+blogshtml(posts), 'blog', 'blog', {title: 'Blog'}
by_tag.each do |k,v|
    head = "<h1>posts tagged #{blogtag k}<span class='all'><a href='/blog'>view all »</a></span></h1><hr class='c'>"
    render "blog/#{k.sub ' ', ?-}", head+blogshtml(v), '../blog', 'blog', {title: "Posts tagged #{k}"}
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
    date, *subtitle = header.split ' // '
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
    render "puzzle/logic/#{p[:id]}", html, '/puzzle/puzzle', 'puzzle', {title: p[:title]}
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

go('pre/atomic') do |html, full, name, name2|
    render "atomicguide/#{name2}", html, name, 'boardgame'
end

%w[puzzle].each do |dir|
    parts = dir.split ?/
    go("pre/#{dir}") do |html, full, name, name2|
        render "#{dir}/#{name2}", html, "/#{dir}/#{parts[-1]}", parts[0]
    end
end
