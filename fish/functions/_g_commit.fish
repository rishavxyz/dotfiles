function _g_commit -a cmd -a title -a msg
    if not test -d .git
        _g_err "not in a git repo"
        return 1
    end

    test (count $argv) = 0 && git commit

    set -l do_command

    if test (count $title) = 0
        set msg $cmd
    else if test (count $msg) = 0
        set msg $cmd: $title
    else
        set msg "$cmd($title): $msg"
    end

    switch $cmd
        case build dist dep
            set cmd build
            set do_command "git commit -m '👷 $msg'"
        case ci cd cicd
            set cmd ci/cd
            set do_command "git commit -m '💚 $msg'"
        case doc docs
            set cmd doc
            set do_command "git commit -m '📝 $msg'"
        case feat feature
            set cmd feat
            set do_command "git commit -m '✨ $msg'"
        case bugfix fix
            set cmd fix
            set do_command "git commit -m '🐛 $msg'"
        case perf performance
            set cmd perf
            set do_command "git commit -m '⚡️ $msg'"
        case ref refactor refactore
            set cmd refactor
            set do_command "git commit -m '♻️  $msg'"
        case ui ux ui/ux
            set cmd ui
            set do_command "git commit -m '🎨 $msg'"
        case style code
            set do_command "git commit -m '🪄 $msg'"
        case test
            set do_command "git commit -m '⚒️  $msg'"
        case '*'
            set msg $argv
            set do_command "git commit -m '$msg'"
    end
    eval $do_command
end
