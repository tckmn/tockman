require_relative 'util'

def f_subpage x
    t, b = (x || '<!--t*-->').split(' || ', 2)
    "<h1>#{t}</h1><p><a href='#{b || '..'}'>« back</a></p>"
end

def f_svg x
    # used for svgs that need to be embedded so that they're cssable
    "<svg viewBox='#{x[0] == ?* ? '-2 -2 4 4' : '-1 -1 2 2'}'>#{File.read "pre/svgs/#{x.sub ?*, ''}.svg"}</svg>"
end

def f_chess x
    fen, moves = x.split ' ', 2

    prev = nil
    moves = moves.scan(/\d+\.+|[,() ]|\[[^\]]*\]|[^ ,)]+/).map{|s|
        x = case s[0]
        when /\d/ then "<span class=n>#{s}</span>"              # number
        when ' ' then prev =~ /\d/ ? '&nbsp;' : ' '
        when ?[ then "<span class=c>#{s[1...-1]}&nbsp;</span>"  # commentary
        when ?( then '<div class=b>'                            # branch
        when ?, then '</div><div class=b>'
        when ?) then '</div>'
        else "<span class=m>#{s}</span>"                        # move
        end
        prev = s[0]
        x
    }.join

    board = fen.gsub(/\d/){?.*$&.to_i}.split(?/).map(&:chars)
    "<div class=chess data-pos='#{fen}'><table><tbody>" + board.map.with_index{|x,i|
        '<tr>' + x.map.with_index{|y,j|
            yd = y.downcase
            "<td class=#{(i+j)%2==0 ? ?l : ?d}><img src='/img/" +
                (y == ?. ? 'no.png' :
                 "#{yd}#{y == yd ? ?d : ?l}.svg") +
                "'></td>"
        }.join + '</tr>'
    }.join + '</tbody></table>' +
    "<div class='mcont'>" +
    "<div class='ctrl'><span>«</span><span><span>flip</span></span><span>»</span></div>" +
    "<div class='moves'>#{moves}</div>" +
    "</div></div><div style='clear:both'></div>"
end

def f_logictbl
    $logic.map {|p|
        "<tr#{" class='ltralt'" if p[:id] % 2 != $logic.size % 2}>
            <td class='ld'>
                <p class='blog'><a href='#{p[:id]}'>#{p[:date].split[0]}#{": <strong>#{p[:subtitle]}</strong>" if p[:subtitle]}</a></p>
                <p>#{p[:shortdesc]}</p>
            </td>
            <td class='ll'>
                #{p[:puzs].map{|puz| "<p><a href='#{puz[:link]}'>#{puz[:type].gsub ?-, '&#8209;'}</a></p>" }.join}
            </td>
            <td class='ls'>
                #{p[:puzs].map{|puz| "<p>#{?★*puz[:diff].to_i}</p>" }.join}
            </td>
        </tr>"
    }.reverse.join
end

def f_tierlist x
    "<table class='tierlist'>
        #{alt = false; x.split(?;).map(&:strip).each_cons(2).map{|prev, val|
            if prev.empty?
                # start row
                "<tr#{' class="alt"' if alt=!alt}><th class='#{val[0].downcase}'>#{val}</th><td>"
            elsif val.empty?
                # end row
                "</td></tr>"
            else
                # data cell
                "<span>#{val}</span><wbr>"
            end
        }.join}
    </table>"
end

def f_heya puz
    sq = 40
    gw = 1
    bw = 2.2
    pad = 10

    pw, ph = puz.match(/(\d+)x(\d+)/).to_a.drop(1).map &:to_i
    sw, sh = pw*sq, ph*sq

    s = ''
    link = puz.match(/^https.*$/)
    s += "<a href='#{link[0]}' target='_blank'>" if link

    s += "<svg xmlns='http://www.w3.org/2000/svg' font-family='main' "
    s += "class='spoiler' " if puz =~ /SPOILER/
    s += "style='vertical-align:middle' "
    s += "width='#{sw+2*pad}' height='#{sh+2*pad}' "
    s += "viewBox='#{-pad} #{-pad} #{sw+2*pad} #{sh+2*pad}'>"
    s += "<g shape-rendering='crispEdges'>"

    rect = ->x, y, w, h, p=bw, fill='black' {
        s += "<rect fill='#{fill}' x='#{x*sq-p}' y='#{y*sq-p}' " +
             "width='#{w*sq+2*p}' height='#{h*sq+2*p}'/>"
    }

    txt = ->t, x, y, fill, sz {
        s += "<text fill='#{fill}' font-size='#{sz}' x='#{x*sq}' y='#{y*sq}' text-anchor='middle' dominant-baseline='central'>#{t}</text>"
    }

    # background
    rect[0, 0, pw, ph, pad, 'white']

    # solution
    isblack = Array.new(ph){[false] * pw}
    if sol = puz.match(/^[-~#?!][-~#?!\n]*/m)
        sol[0].strip.lines.each.with_index do |row, y|
            row.chomp.chars.each.with_index do |ch, x|
                if ch != ??
                    rect[x, y, 1, 1, 0, {
                        ?- => '#a0ffa0',
                        ?! => '#ffa0a0',
                        ?~ => '#888',
                        ?# => '#000'
                    }[ch]]
                    isblack[y][x] = ch == ?#
                end
            end
        end
    end

    # gridlines
    (1...pw).each do |i|
        s += "<path fill='none' stroke='#7f7f7f' stroke-width='#{gw}' d='M #{i*sq} 0 V #{sh}'/>"
    end
    (1...ph).each do |i|
        s += "<path fill='none' stroke='#7f7f7f' stroke-width='#{gw}' d='M 0 #{i*sq} H #{sw}'/>"
    end

    # borders
    rect[0,  0,  pw, 0]  unless puz =~ /!T/
    rect[0,  ph, pw, 0]  unless puz =~ /!B/
    rect[0,  0,  0,  ph] unless puz =~ /!L/
    rect[pw, 0,  0,  ph] unless puz =~ /!R/

    # rooms
    puz.scan(/(\d+) (\d+) (\d+)x(\d+) (\d+|-1)/).each do |room|
        x, y, w, h, n = room.map &:to_i
        rect[x, y, w, 0]
        rect[x, y+h, w, 0]
        rect[x, y, 0, h]
        rect[x+w, y, 0, h]
        txt[n, x+0.5, y+0.5, isblack[y][x] ? '#fff' : '#000', 28] unless n == -1
    end

    # extra borders
    puz.scan(/BORDER (\d+) (\d+) (-?\d+)/).each do |bord|
        x, y, n = bord.map &:to_i
        rect[x, y, n>0 ? n : 0, n<0 ? -n : 0]
    end

    # stop crispEdges
    s += "</g>"

    # curves

    puz.scan(/^CURVE (.*)$/).each do |curv|
        s += "<path fill='none' stroke='red' stroke-dasharray='4' stroke-width='2' d='"
        px, py = []
        curv[0].split.each_slice(2).each do |c|
            x, y = c.map &:to_i
            dir = c.join.include?(?*)? -1 : 1
            s +=
                px.nil? ? 'M ' :
                px != x && py != y ? ' L ' :
                " Q #{(px == x ? x+dir*0.5 : (px+x)/2.0)*sq} #{(py == y ? y+dir*0.5 : (py+y)/2.0)*sq} "
            s += "#{x*sq} #{y*sq}"
            px, py = x, y
        end
        s += "'/>"
    end

    # loops

    doloop = -> col, cfn, ctr=nil, fake=[] {
        adj = ctr ? 0.1 : 0
        ctr ||= [0,0]
        (0...pw).each do |x|
            (0...ph).each do |y|
                next if isblack[y][x]
                next unless cfn[x, y]
                if cfn[x, y+1] && !isblack[y+1][x] && !fake.include?([x,y,x,y+1])
                    adjx = x < ctr[0] ? adj : -adj
                    adjy1 = cfn[x, y-1] ? (!isblack[y-1][x] ? 0 : -adj) : adj
                    adjy2 = cfn[x, y+2] ? (!isblack[y+2][x] ? 0 : adj) : -adj
                    s += "<path fill='none' stroke='#{col}' stroke-width='2' d='"
                    s += "M #{(x+0.5+adjx)*sq} #{(y+0.5+adjy1)*sq} V #{(y+1.5+adjy2)*sq}"
                    s += "'/>"
                end
                if cfn[x+1, y] && !isblack[y][x+1] && !fake.include?([x,y,x+1,y])
                    adjx1 = cfn[x-1, y] ? (!isblack[y][x-1] ? 0 : -adj) : adj
                    adjx2 = cfn[x+2, y] ? (!isblack[y][x+2] ? 0 : adj) : -adj
                    adjy = y < ctr[1] ? adj : -adj
                    s += "<path fill='none' stroke='#{col}' stroke-width='2' d='"
                    s += "M #{(x+0.5+adjx1)*sq} #{(y+0.5+adjy)*sq} H #{(x+1.5+adjx2)*sq}"
                    s += "'/>"
                end
            end
        end
    }

    if puz =~ /^LOOPS (#\w+)$/
        doloop[$1, ->x,y{ x<pw && y<ph }, nil]
    end

    puz.scan(/^CLOOP (#\w+) ([0-9 ]+)(?: F (.*))?$/).each do |col, rects, fake|
        coords = rects.split.map(&:to_i).each_slice(4).flat_map{|x, y, w, h|
            (0...w).flat_map{|dx| (0...h).map{|dy| [x+dx, y+dy] }}
        }.uniq
        doloop[col, ->x,y{ coords.include? [x,y] },
               coords.transpose.map{|z| z.sum/coords.size.to_f},
               (fake || '').split.map(&:to_i).each_slice(4)]
    end

    # gridpoints

    reg = ->n {
        "<polygon points='#{Array.new(n){|i|
            "#{Math.sin(i*2*Math::PI/n)},#{-Math.cos(i*2*Math::PI/n)}"
        }.join ' '}'/>"
    }

    star = ->n, r=0 {
        "<polygon points='#{Array.new(n){|i|
            sc = i % 2 == r ? 1 : 0.5
            "#{sc*Math.sin(i*2*Math::PI/n)},#{sc*-Math.cos(i*2*Math::PI/n)}"
        }.join ' '}'/>"
    }

    shapes = {
        ?o => "<circle r='0.8'/>",
        ?3 => reg[3],
        ?4 => reg[4],
        ?5 => reg[5],
        ?6 => reg[6],
        ?* => star[10],
        ?x => star[8,1],
        ?+ => "<rect x='-0.2' y='-0.8' width='0.4' height='1.6'/><rect x='-0.8' y='-0.2' width='1.6' height='0.4'/>",
        ?~ => "<path d='M -0.8 0.4 Q -0.4 1 0 0.4 T 0.8 0.4 V -0.4 Q 0.4 -1 0 -0.4 T -0.8 -0.4 z'/>",
    }

    colors = {
        ?R => '#f00',
        ?B => '#0cf',
        ?G => '#0f0',
        ?O => '#f80',
        ?P => '#80f',
        ?M => '#f0f',
        ?Y => '#aa0',
        ?A => '#888',
        ?W => '#a60',
    }

    if grid = puz.match(/grid\n(.+)\nend/m)
        grid[1].lines.each.with_index do |row, y|
            row.chomp.chars.each_slice(2).with_index do |spec, x|
                ch, shape = spec
                if ch != ?.
                    s += "<g fill='#{colors[ch] || '#444'}' transform='translate(#{x*sq} #{y*sq}) scale(12)'>"
                    s += shapes[shape]
                    txt[ch !~ /[0-9a-z]/ ? '' : ch == ?0 ? 36 : ch.to_i(36), 0, 0, '#fff', 1]
                    s += "</g>"
                end
            end
        end
    end

    s += "</a>" if link
    s += "</svg>"
    s
end

@comments = eval File.read('comments')

def f_comments x, props
    props.script = (props.script || []) + ['comments']
    comments = @comments.filter{|c| c[:post] == x }
    <<~x
    <h2 id='comments'>comments</h2>
    #{comments.empty? ? '<p><i>There are no comments yet.</i></p>' : comments.map{|c|
        <<~y
        <div class='comm'>
            <p class='commh'>
                <strong class='commn#{c[:name] == 'tckmn' ? ' me' : ''}'>#{c[:name]}</strong>
                <em class='commd'>#{c[:date].split(?:)[0...-1].join(?:)}</em>
            </p>
            <p class='commb'>#{c[:comm]}</p>
        </div>
        y
    }.join}
    <form id='commentform' method='post' action='https://dyn.tck.mn/comment'>
        <p><label>name: <input name='name'></label></p>
        <p><label>contact (private, optional): <input name='cont'></label></p>
        <p id='commentinfo'>
            <a href='https://www.markdownguide.org/cheat-sheet/' target='_blank'>markdown</a> is supported.
            comments require manual approval.
        </p>
        <p><textarea name='comm' rows='5'></textarea></p>
        <p>
            <input type='hidden' name='post' value='<!--u-->'>
            <input type='submit' id='commentsubmit' value='leave a comment'>
            <span id='commentfeedback'></span>
        </p>
    </form>
    x
end

def f_style x, props
    style = x.start_with?('<style>') ? sass(x.gsub(/<\/?style>/, ''), props.fname.gsub(/^\/+|\/+$/, '').gsub(?/, ?_)) : x
    props.style = (props.style || []) + [style]
    ''
end

def onespecial props, a, b, c, d
    d.dedent!.chomp! if d
    m = :"f_#{a}"
    if private_methods.include? m
        case method(m).arity
        when 0 then method(m).call
        when 1 then method(m).call d
        when 2 then method(m).call d, props
        end
    else
        case b
        when ?\s then props[a] = d
        when ?+  then props[a] = (props[a] || []) + [d]
        else          props[a] = true
        end
        c ? '' : d
    end
end

def special s, props
    s.gsub /^\s*\.(\w+)([ +])(!)?{{(.*?)\s*}}$/m do
        onespecial props, $1, $2, $3, $4
    end.gsub /^\s*\.(\w+)(?:([ +])(.*))?/ do
        onespecial props, $1, $2, true, $3
    end
end
