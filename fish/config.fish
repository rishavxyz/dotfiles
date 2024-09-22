if status is-interactive
    set fish_greeting
    set -q Z_CMD; and set Z_CMD j

    if functions -q fzf_configure_bindings
        set -q fzf_fd_opts
        or set fzf_fd_opts --hidden --max-depth=5 \
            -E node_modules -E .local/share -E .local/state -E .bun \
            -E .cabal -E .cache -E .cargo -E .fehbg -E .mozilla \
            -E .ghcup -E .pki -E .rustup -E .stack -E .vscode \
            -E .zen -E .android -E .gtkrc-2.0 -E .npm -E .dbus

        fzf_configure_bindings \
            --directory=\cf --history=\ch --git_status=\cg
        #         ctrl+f        ctrl+h        ctrl+g
    end

    # key bindings
    # ctrl + shift + ,
    bind \e\[60\;6u "source $__fish_config_dir/config.fish && \
      notify-send 'Fish shell' 'Config file sourced from <b>$__fish_config_dir/</b>'"
    bind \e\[62\;6u 'fish --private' # ctrl + shift + .
    bind \e\[63\;6u tmux #             ctrl + shift + /

    # # add PATH entries here
    # # it will prepend them $PATH by fish
    set fish_user_paths \
        $BUN_INSTALL/bin \
        ~/.local/share/gem/ruby/3.3.0/bin \
        ~/.local/share/go/bin \
        ~/.ghcup/bin \
        ~/.local/bin \
        ~/.cargo/bin
end
