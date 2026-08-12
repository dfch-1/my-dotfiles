if test "$XDG_CURRENT_DESKTOP" = "Hyprland"
    function fish_prompt
    set -l last_status $status
    set -l duration $CMD_DURATION

    set_color $ckull
    echo -n "╭──("
    set_color red
    echo -n (whoami)
    echo -n "@"
    echo -n (hostname)
    set_color $ckull
    echo -n ")-["
    set_color red
    echo -n " "
    echo -n (string replace $HOME "~" (pwd))
    set_color $ckull
    echo -n "]"
    set_color normal

    set -l branch (fish_git_prompt "%s")
    if test -n "$branch"
        set_color $ckull
        echo -n "-["
        set_color ef5033
        echo -n "Git  "
        set_color magenta
        echo -n "("
        echo -n "$branch"
        echo -n ")"
        set_color $ckull
        echo -n "]"
    end

    if test $duration -gt 2000
    set_color $ckull
    echo -n "-("
    set_color yellow
    echo -n " "

    if test $duration -gt 60000
        echo -n (math round $duration / 60000) "m"
    else
        echo -n (math round $duration / 1000)"s"
    end

    set_color $ckull
    echo -n ")"
    end

    set_color $ckull
    echo ""
    echo -n "╰─"

    if test $last_status -ne 0
        set_color ff0000
    else
        set_color green
    end
    echo -n "❯ "
    set_color normal
    end
else
    function fish_prompt
        echo -n (pwd)

        #if test "$PWD" = "/"
        #    echo -n ""
        #else
        #    echo -n "/"
        #end

        echo -n '> '
    end
end
