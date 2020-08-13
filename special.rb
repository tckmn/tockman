require 'ostruct'

def chessparse moves
    prev = nil
    moves.scan(/\d+\.+|[,() ]|\[[^\]]*\]|[^ ,)]+/).map{|s|
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
end

def special s
    props = OpenStruct.new
    html = s.gsub /^\s*\.chess ([^ ]*)(?: (.*))?/ do
        # CHESS
        fen, moves = $1, $2
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
        "<div class='moves'>#{chessparse moves}</div>" +
        "</div></div><div style='clear:both'></div>"
    end.gsub /^\s*\.logictbl/ do
        $logic.map {|p|
            p[:puzs].map.with_index{|puz,pi|
                classes = [
                    pi == 0                       ? 'ltrfst' : nil,
                    pi == p[:puzs].size-1         ? 'ltrlst' : nil,
                    p[:id] % 2 != $logic.size % 2 ? 'ltralt' : nil
                ].compact
                "<tr#{classes.empty? ? '' : " class='#{classes*' '}'"}>
                    <td class='ld'>#{pi == 0 ? "<a href='#{p[:id]}'>#{p[:date].split[0]}</a>" : ''}</td>
                    <td class='ll'><a href='#{puz[:link]}'>#{puz[:type]}</a></td>
                    <td class='ls'>#{?★*puz[:diff].to_i}</td>
                </tr>"
            }
        }.reverse.join
    end.gsub /^\s*\.subpage(?: (.*))?/ do
        "<h1>#{$1 || '<!--t*-->'}</h1><p class='ni'><a href='..'>« back</a></p>"
    end.gsub /^\s*\.svg (.*)/ do
        "<svg viewBox='#{$1[0] == ?* ? '-2 -2 4 4' : '-1 -1 2 2'}'>#{File.read "pre/svgs/#{$1.sub ?*, ''}.svg"}</svg>"
    end.gsub /^\s*\.(\w+)(?:([ +])(.*))?/ do
        case $2
        when ?\s then props[$1] = $3
        when ?+  then props[$1] = (props[$1] || []) + [$3]
        else          props[$1] = true
        end
        ''
    end
    [html, props]
end
