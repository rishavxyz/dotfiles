function gut -d 'A very fancy wrapper for git' -w git
    switch $argv[1]
        case cl clone
            _g_clone $argv[2..]
        case st status
            _g_status
        case cm commit
            _g_commit $argv[2..]
        case ad add
            set -l args $argv[2..]
            if test (count $args) = 0
                command git add .
            else
                command git add $args
            end
        case '*'
            command git $argv[2..]
    end
end
