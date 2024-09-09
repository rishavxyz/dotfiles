function _g_clone -d "git clone easy way"
    argparse s/ssh -- $argv; or return

    set -l url $argv[1]

    if test (count $url) = 0
        _g_err "need one repo url"
        return 1
    end

    if not string match -qir '^[a-z]' $url
        _g_err "not a valid url"
        return 1
    end

    if not string match -qir '^(http|https)://[a-z]+' $url
        set url "https://github.com/$url"
    end

    command git clone $url
end
