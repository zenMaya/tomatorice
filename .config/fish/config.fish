set -U fish_user_paths $HOME/.scripts /home/yachimm_thomasegh/.gem/ruby/2.6.0/bin /home/yachimm_thomasegh/.vimpkg/bin  $fish_user_paths

#(ruby -e 'print Gem.user_dir')/bin

set -Ux TERMINAL termite
set -Ux BROWSER firefox
set -Ux EDITOR nvim
set -Ux GIT_EDITOR nvim

##############ALIASES##############
function ls
    command ls --color=never $argv
end
function lsa
    command ls -cClAhG --color=never $argv
end

function config
  command /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end

#Pacman
function pacman
    command sudo pacman $argv
end
function pacs
    command sudo pacman -S $argv
end
function pacsy
    command sudo pacman -Sy $argv
end
function pacsyu
    command sudo pacman -Syu $argv
end
function pacsyyu
    command sudo pacman -Syyu $argv
end
function pacsrub
    command sudo pacman -S ruby-$argv
end

if status --is-login
   config pull &
end
