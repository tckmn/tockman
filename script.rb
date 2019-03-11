#!/usr/bin/ruby
require 'fileutils'
require 'time'
require_relative 'special'

$template = File.read('pre/template.html')
$target = 'tckmn.github.io'

def go path, &blk
    Dir.entries(path).each do |fname|
        next if fname == 'template.html' || File.directory?("#{path}/#{fname}")
        full, name = "#{path}/#{fname}", fname.split('.')[0]
        blk.call File.read(full), full, name
    end
end

def render title, html, name, active, ksh=false
    $script = []
    ret = $template
        .sub('<title>', "\\0#{title}#{title && ' - '}")
        .sub('<!--*-->', special(html))
        .sub('<!--s-->', $script.map{|x|"<script src='/js/#{x}.js'></script>"}.join)
        .sub("'css'", "'#{name}.css'")
        .sub(/(href='\/#{active}')(?: class='([^']*)')?/, '\1 class=\'active \2\'')
    ret.sub!(/<div id='subheader'>.*?<\/div>/m, '') if ksh
    ret
end

def out fname, html, noindex=false
    fname = "#{$target}/#{fname}#{noindex ? '.html' : '/index.html'}"
    FileUtils.mkdir_p fname.sub(/[^\/]*$/, '')
    File.write fname, html
end

go('pre') do |html, full, name|
    name2 = name.sub 'index', ''
    out name2, render({
        about: 'About',
        conlang: 'Conlangs',
        contact: 'Contact',
        index: nil,
        lingpuzzle: 'Linguistics puzzles',
        manalyze: 'Music analysis',
        mcompose: 'Composition',
        portfolio: 'Portfolio'
    }[name.to_sym], html, name, name2, name == 'index'), name == '404'
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
go('pre/blog') do |html, full, name|
    content = `cmark #{full}`.lines.drop(1).join
    date, tags = html.lines.first.chomp.split(nil, 2)
    tags = tags.split ?,
    title = content.split(?<)[1][3..-1]

    post = {
        name: name, date: date, tags: tags, title: title,
        excerpt: `tail -n+5 #{full} | sed -n '/<!--\\*-->/{q};p' | cmark`
    }
    posts.push post
    tags.each do |tag| by_tag[tag].push post; end

    out "blog/#{name}", render(title, content.sub('</h1>', "\\0#{bloghtml post, false}"), name, 'blog')
end

# index pages
hint = "<p class='ni' style='margin-bottom:-10px'>Click a tag to filter by posts with that tag. <a href='/blog.xml' style='float:right'><img src='/img/rss.png'></a></p>"
out 'blog', render('Blog', hint+blogshtml(posts), 'blog', 'blog')
by_tag.each do |k,v|
    head = "<h1>posts tagged #{blogtag k}<span class='all'><a href='/blog'>view all »</a></span></h1><hr class='c'>"
    out "blog/#{k.sub ' ', ?-}", render("Posts tagged #{k}", head+blogshtml(v), '../blog', 'blog')
end

# rss
File.open("#{$target}/blog.xml", 'w') do |f|
    f.puts <<~x
    <rss version="2.0">
        <channel>
            <title>Blog - Andy Tockman</title>
            <link>https://tck.mn/blog/</link>
            <description>Andy Tockman's blog</description>
            <language>en</language>
    #{posts.map do |p| <<~y
        <item>
            <title>#{p[:title].encode :xml => :text}</title>
            <link>https://tck.mn/blog/#{p[:name]}/</link>
            <description>#{p[:excerpt].gsub(/<[^>]*>/, '').chomp.encode :xml => :text}</description>
            <pubDate>#{Time.parse(p[:date]).rfc2822}</pubDate>
            <guid>https://tck.mn/blog/#{p[:name]}/</guid>
        </item>
    y
    end * "\n"}
        </channel>
    </rss>
    x
end

go('pre/atomic') do |html, full, name|
    name2 = name.sub 'index', ''
    out "atomicguide/#{name2}", render(({
        index: '',
        intro: 'Introduction',
        opening1: 'Basic openings',
        tactic1: 'Common tactics',
        endgame1: 'Basic endgames'
    }[name.to_sym] + ' - Atomic chess guide').sub(/^ - /, ''), html, name, 'asdf')
end

go('pre/cryptic') do |html, full, name|
    name2 = name.sub 'index', ''
    out "cryptic/#{name2}", render('Cryptic crosswords', html, '/cryptic/cryptic', 'asdf')
end
