function __gen_pkg_cmds -d 'generates abbrs for os package managers'
    function is_it
        grep -iq $argv[1] /etc/os-release
    end

    if is_it arch
        abbr -a i -- 'sudo pacman --needed -S'
        abbr -a r -- 'sudo pacman -Runsc'
        abbr -a rdd -- 'sudo pacman -Rddns'
        abbr -a s -- 'pacman -Ss'
        abbr -a si -- 'pacman -Si'

        # check aur helper
        set -l aur_helper
        set -l aur_cmd_install
        set -l aur_cmd_search

        if type -q aura
            set aur_helper aura
            set aur_cmd_install -Acax
            set aur_cmd_search -As
        else if type -q paru
            set aur_helper paru
            set aur_cmd_install -S
            set aur_cmd_search -Ss
        else if type -q yay
            set aur_helper aura
            set aur_cmd_install -S
            set aur_cmd_search -Ss
        end

        abbr -a ia -- "$aur_helper $aur_cmd_install"
        abbr -a sa -- "$aur_helper $aur_cmd_search"

    else if is_it debian
        abbr -a i -- 'sudo apt install'
        abbr -a r -- 'sudo apt remove'
        abbr -a s -- 'apt search'
        abbr -a si -- 'apt list'

    else if is_it void
        abbr -a i -- 'sudo xbps-install'
        abbr -a s -- 'xbps-query -Rs'
        abbr -a r -- 'sudo xbps-remove -Ro'
        abbr -a si -- xbps-query
    end
    functions -e is_it
end
__gen_pkg_cmds

abbr -a G -p anywhere '| grep -i'
abbr -a W -p anywhere --set-cursor '%| wc -l'
abbr -a L -p anywhere --set-cursor '%| less'
