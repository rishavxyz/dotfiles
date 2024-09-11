function vpn -d "setup vpn with wireguard"
    set -l intf $argv[2] (wg show interfaces)
    set -l cmd_up wg-quick up
    set -l cmd_dn wg-quick down

    if not fish_is_root_user
        set -p cmd_up sudo
        set -p cmd_dn sudo
    end

    set intf $intf[1]

    switch $argv[1]
        case c con connect up
            if [ -z $intf ]
                echo "Need an interface name"
                return
            end
            eval "$cmd_up $intf"

        case d dis disconnect down docn
            if [ -z $intf ]
                echo "Not connected to shutdown"
                return
            end
            eval "$cmd_dn $intf"

        case s stat status
            if test -z $intf
                echo "Not connected to show status"
                return
            end
            echo VPN connected to interface: $intf

        case '*'
            echo 'USAGE:'
            echo -e '  vpn c|con|connect <interface>\t to connect'
            echo -e '  vpn d|dis|down <interface?>  \t to disconnect, interface is optional'
            echo -e '  vpn s|stat|status            \t show status'
    end
end
