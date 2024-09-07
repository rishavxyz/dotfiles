function pp -d 'Pretty print text'
    string pad -c - '' (printf '| %s |' "$argv") ''
end
