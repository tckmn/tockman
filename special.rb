require_relative 'util'

def f_subpage x
    "<h1>#{x || '<!--t*-->'}</h1><p><a href='..'>« back</a></p>"
end

def f_svg x
    # used for svgs that need to be embedded so that they're cssable
    "<svg viewBox='#{$1[0] == ?* ? '-2 -2 4 4' : '-1 -1 2 2'}'>#{File.read "pre/svgs/#{$1.sub ?*, ''}.svg"}</svg>"
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

def onespecial props, a, b, c, d
    d.dedent!.chomp! if d
    m = :"f_#{a}"
    if private_methods.include? m
        if method(m).arity == 0 then method(m).call
        else method(m).call d
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

def special s
    props = {}
    html = s.gsub /^\s*\.(\w+)([ +])(!)?{{(.*?)^\s*}}$/m do
        onespecial props, $1, $2, $3, $4
    end.gsub /^\s*\.(\w+)(?:([ +])(.*))?/ do
        onespecial props, $1, $2, true, $3
    end
    [html, props]
end
