function g -d 'A very fancy wrapper for git'
    # set -l cmds cl pl ph st cm rs br log

    if test (count $argv) = 0
        echo TODO: show helo
        return
    end

    switch $argv[1]
        case cl clone
            _g_clone $argv[2..]
        case s st status
            _g_status
        case c cm commit
            _g_commit $argv[2..]
        case '*'
            echo ':D'
    end
end
