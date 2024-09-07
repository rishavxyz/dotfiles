if status is-interactive
    set fish_greeting ''

    if functions -q fzf_configure_bindings
        set -q fzf_fd_opts
        or set fzf_fd_opts --hidden --max-depth=5 \
            -E node_modules/ -E .local/share/ -E .local/state/ -E .bun/ \
            -E .cabal/ -E .cache/ -E .cargo/ -E .fehbg/ -E .mozilla/ \
            -E .ghcup/ -E .pki/ -E .rustup/ -E .stack/ -E .vscode/ \
            -E .zen/ -E .android/ -E .gtkrc-2.0/ -E .npm/

        set -q fzf_preview_file_cmd
        or set fzf_preview_file_cmd cat

        fzf_configure_bindings \
            --directory=\cf \
            --history=\ch \
            --git_status=\cg
    end

    if type -q eza
        alias ls='eza --icons=always'
        alias ll='ls -l'
        alias l='ls -T -L1'
        alias l='ll'
        alias la='ls -la'
    end

    type -q bat; and alias cat='bat --style=full'
    type -q z; and alias j=z

    functions -q qotd; and qotd

    # # add PATH entries here
    # # it will prepend them $PATH by fish
    set fish_user_paths \
        $BUN_INSTALL/bin \
        ~/.local/share/gem/ruby/3.2.0/bin \
        ~/projects/go/bin \
        ~/.ghcup/bin \
        ~/.local/bin
end
