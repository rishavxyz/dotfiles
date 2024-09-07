function qotd -d 'Quote of the day'
    if test -z $__fish_config_dir/quotes
        echo -s "I can't find any quotes in $__fish_config_dir" '/quotes file'
        return
    end
    set -l quotes (command cat $__fish_config_dir/quotes)
    set -l random_quote (random choice $quotes)
    set -l todays_quote (string split ':' $random_quote)
    set -l quote (printf ' “%s”' $todays_quote[1])
    set -l author (printf '%s' $todays_quote[2])

    echo $quote
    set_color -i
    string pad \
        -w (math min "$COLUMNS,$(string length $quote)") \
        "— $author "
    set_color normal
end
