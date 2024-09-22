function _g_clone -d "git clone easy way" -a url
    argparse -n "git clone" -x n,o \
        "d#depth" "b/branch=" "o/origin=" \
        n/no-checkout r/recursive -- $argv
    or return

    set -q _flag_d && set -l depth "--depth=$_flag_d"
    set -q _flag_b && set -l branch "--branch=$_flag_b"
    set -q _flag_o && set -l origin "--origin=$_flag_o"
    set -q _flag_n && set -l nocheckout --no-checkout
    set -q _flag_r && set -l recursive --recursive

    if string match -qir '^ssh:+' $url
        set url (string replace 'ssh:' '' -- $url)
    else
        if not string match -qir '^((http|https)://|)\w+\.\w+' $url
            set url "github.com/$url"
        end

        if not string match -qir '^http(s|)://+' $url
            set url "https://$url"
        end
    end

    set -l cmd git clone $url $depth $branch $origin $nocheckout $recursive
    eval "$cmd $argv[2]"
end
