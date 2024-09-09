function copy -d "copy CWD using xsel"
    if not type -q xsel
        echo 'need "xsel" to be installed'
        return 1
    end

    if test (count $argv) = 0
        realpath . | xsel -ib
    else
        realpath $argv[1] | xsel -ib
    end
end
