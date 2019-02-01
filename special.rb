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

def chess s
    s.gsub /^\s*\.chess ([^ ]*)(?: (.*))?/ do
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
    end.gsub /^\s*\.script (.*)/ do
        $script.push $1
        ''
    end
end

def special s; chess s; end
