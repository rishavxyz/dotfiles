function _g_status
    if not test -d .git
        _g_err "not in a git repo"
        return 1
    end
    command git status
end
