#/root/.bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

# are we an interactive shell?
if [ "$PS1" ]; then
  if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
    xterm*)
      if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
          PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
      else
          PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
      fi
      ;;
    screen)
      if [ -e /etc/sysconfig/bash-prompt-screen ]; then
          PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
      else
          PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
      fi
      ;;
    *)
      [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
      ;;
    esac
  fi

# Turn on parallel history
shopt -s histappend
history -a

# Turn on checkwinsize
shopt -s checkwinsize
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
# You might want to have e.g. tty in prompt (e.g. more virtual machines)
# and console windows
  # If you want to do so, just add e.g.
  # if [ "$PS1" ]; then
  #   PS1="[\u@\h:\l \W]\\$ "
  # fi
  # to your custom modification shell script in /etc/profile.d/ directory
fi

if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it get's undefined at the end of /etc/profile
    pathmunge () {
        case ":${PATH}:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
        esac
    }

# By default, we want umask to get set. This sets it for non-login shell.
# Current threshold for system reserved uid/gids is 200
# You could check uidgid reservation validity in
# /usr/share/doc/setup-*/uidgid file
if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
       umask 002
    else
       umask 022
    fi

# Only display echos from profile.d scripts if we are no login shell
# and interactive - otherwise just process them to set envvars
for i in /etc/profile.d/*.sh; do
        if [ -r "$i" ]; then
            if [ "$PS1" ]; then
                . "$i"
            else
                . "$i" >/dev/null
            fi
        fi
    done

    unset i
    unset -f pathmunge
fi
# vim:ts=4:sw=4

# User specific environment and startup programs
# This is commented out so I can cat the /etc/motd
#fortune zippy| cowsay | lolcat
#force_color_prompt=yes


#Display /etc/motd on login
cat /etc/motd

# Dynamic resizing
shopt -s checkwinsize

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

#Here are a few options for configuring our command prompt
#Feel free to add more
#export PS1="\e[0;34m[\u@\h \W]\$ \e[m "
#PS1='\[33[01;32m\]\u@\h\[33[00m\]:\[33[01;34m\]\w\[33[00m\]\$ '
#PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"
#PS1="\e[32;1m\]\u@\[\e[35;1m\]\H \[\e[0m\]\w]\$ "
#PS1="\a\n\n\e[31;1m\u@\h on \d at \@\n\e[33;1m\w\e[0m\n$ "
#PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"
#PS1='\n\[\033[1;34m\]\342\226\210\342\226\210 \u @ \w\n\[\033[0;36m\]\342\226\210\342\226\210 \t $ \[\033[0;39m\]'
#Cygwin Look
PS1='\[\e]0;\w\a\]\n\[\e[1;35m\]\u@\h: \[\e[1;35m\]\w\[\e[0m\]\n\$ '
export PS1

#Setup any user command aliases here
alias jump='/home/paquinchadmin/bin/jump.bash'
alias push='/home/paquinchadmin/bin/push.bash'
alias console='/home/paquinchadmin/bin/console.bash'
alias vi="vim"
