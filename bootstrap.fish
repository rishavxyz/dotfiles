#!/usr/bin/env fish

set _cd $XDG_CONFIG_HOME ~/.config
set dest_dir $_cd[1]
set file_dirs (command ls -d */)
set dot_files xinitrc zshrc zshrc.local
set backup_dir $dest_dir/old.d

function error
    set_color red -o
    echo -n "ERROR: "
    set_color normal
    echo -e $argv
end
function warn
    set_color yellow -o
    echo -n "WARN: "
    set_color normal
    echo -e $argv
end
function ok
    set_color green -o
    echo -n "OK: "
    set_color normal
    echo -e $argv
end
function grey
    set_color '#a2a2a2'
    echo -e $argv
    set_color normal
end

# see if ~/.config/old.d/ is present
if test -d $backup_dir
    error "directory 'old.d/' is present in $dest_dir/"
    grey " - either move that directory or edit this file and set a different 'backup_dir' name"
    return 1
else
    # we create this even if we may not need this
    # at the last, we remove it if it's empty
    mkdir $backup_dir
end

for d in $file_dirs
    set -l dir $dest_dir/$d

    if test -d $dir
        warn "found '$d' in $dest_dir/"
        grey " - moving it to $backup_dir/"
        mv $dir $backup_dir/
        echo
    end
end

# we want to know if the user wants to either just copy
# these files or create a symlink between them
echo -e "You can symlink each of these folders to $dest_dir/" \
    "or just copy them (default). You are now" \
    "going to be asked if you want to symlink them or not..." \
    | fmt -g 60
echo
read -l -P "Do you wish to symlink them? [y/N] " ans

test $ans = ''
or echo "Chosen: $ans"

set ans (string split '' "$ans")
test (string upper $ans[1]) = Y
and set use_symlink

echo
set -q use_symlink
and ok I will SYMLINK these folders "\n"
or ok I will just COPY these folders "\n"

sleep 1

for d in $file_dirs
    if set -q use_symlink
        grey "- symlink '$d' to $dest_dir/"
        ln -s $(realpath $d) $dest_dir/
    else
        grey "- copying '$d' to $dest_dir/"
        cp -r $d $dest_dir/
    end
    echo
end
or error I am unable to place them in $dest_dir/

# now ask the user if they want to
# copy my zshrc, xinitrc files
echo -e "Do you want to use my" \
    "$(string join ', ' $dot_files) files?" \
    "If so then your exsisting rc files will be replaced." \
    "NOTE: They will be safely backed up before doing so." \
    | fmt -g 60
echo
read -l -P "Do you wish to continue? [y/N] " ans

test $ans = ''
or echo "Chosen: $ans"

set ans (string split '' "$ans")
test (string upper $ans[1]) = Y
and set use_my_dotfiles

echo
set -q use_my_dotfiles
or ok not setting them up "\n"

sleep 1

if set -q use_my_dotfiles
    ok using my rc files "\n"

    for f in $dot_files
        set f .$f
        if test -f ~/$f
            warn "found '$f' in $HOME/"
            grey " - moving it to $backup_dir/"
            mv $HOME/$f $backup_dir/
        end
        echo
    end

    for f in $dot_files
        if set -q use_symlink
            grey "- symlink '$f' to $HOME/.$f"
            ln -s $(realpath $f) $HOME/.$f
        else
            grey "- copying '$f' to $HOME/.$f"
            cp -r $f $HOME/.$f
        end
        echo
    end
end
or error I am unable to set up the rc files in $HOME/

if test $status -eq 0
    ok everything is set and done!
else
    error "something went wrong"
    grey " please set up yourself"
end

# cleanup
functions -e error
functions -e ok
functions -e grey
functions -e warn

not count $backup_dir/* >/dev/null
and rmdir $backup_dir
