#!/usr/bin/env ruby

require 'fileutils'
require 'time'
require_relative 'special'

$template = File.read 'pre/template.html'
$target = 'tckmn.github.io'

def go path, ext='html', &blk
    Dir.entries(path).each do |fname|
        next if fname == 'template.html' || File.directory?("#{path}/#{fname}") || fname.split('.')[1] != ext
        full, name = "#{path}/#{fname}", fname.split('.')[0]
        blk.call File.read(full), full, name, name.sub('index', '').gsub('_', '/')
    end
end

def render title, html, name, active='asdf', ksh=false
    $script = []
    $pind = false
    ret = $template
        .sub('<title>', "\\0#{title}#{title && ' - '}")
        .sub('<!--*-->', special(html))
        .sub('<!--s-->', $script.map{|x|"<script src='/js/#{x}.js'></script>"}.join)
        .sub('<body>', $pind ? '<body class=pind>' : '<body>')
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

    out "blog/#{name}", render(title, ".pind\n" + content.sub('</h1>', "\\0#{bloghtml post, false}"), name, 'blog')
end

# index pages
hint = "<p class='ni' style='margin-bottom:-10px'>Click a tag to filter by posts with that tag. <a href='/blog.xml' style='float:right'><img src='/img/rss.png'></a></p>"
out 'blog', render('Blog', hint+blogshtml(posts), 'blog', 'blog')
by_tag.each do |k,v|
    head = "<h1>posts tagged #{blogtag k}<span class='all'><a href='/blog'>view all »</a></span></h1><hr class='c'>"
    out "blog/#{k.sub ' ', ?-}", render("Posts tagged #{k}", head+blogshtml(v), '../blog', 'blog')
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
    date, *puzs, desc = pset.lines
    puzs.map! do |puz|
        diff, link = puz.split
        { diff: diff, link: link, type: link.split(??)[1].split(?/)[0] }
    end
    { id: i+1, date: date, puzs: puzs, desc: desc,
      title: "Puzzles ##{i+1} (#{listtypes puzs.map{|puz| puz[:type]}})" }
end

$logic.each do |p|
    html = <<~x
    <h1>#{p[:title]}</h1>
    <p id='ldat'>posted #{p[:date]}</p>
    <p><a href='..'>« back</a></p>
    <p>#{p[:desc]}</p>
    <p><i>(You can click the images to solve these puzzles with an online interface.)</i></p>
    #{p[:puzs].map.with_index{|puz,i| <<~y
        <div class='lpuz'>
            <p>#{puz[:type]}, difficulty #{?★*puz[:diff].to_i}</p>
            <p><a href='#{puz[:link]}'><img src='/img/logic-#{p[:id]}-#{i}.png'></a></p>
        </div>
        y
    }*''}
    x
    out "puzzle/logic/#{p[:id]}", render(p[:title], html, '/puzzle/puzzle', 'puzzle')
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
    out "atomicguide/#{name2}", render(({
        index: '',
        intro: 'Introduction',
        opening1: 'Basic openings',
        tactic1: 'Common tactics',
        endgame1: 'Basic endgames'
    }[name.to_sym] + ' - Atomic chess guide').sub(/^ - /, ''), html, name)
end

%w[cryptic puzzle].each do |dir|
    go("pre/#{dir}") do |html, full, name, name2|
        out "#{dir}/#{name2}", render({
            cryptic: 'Cryptic crosswords',
            puzzle: 'Puzzles'
        }[dir.to_sym], html, "/#{dir}/#{dir}", dir)
    end
end
