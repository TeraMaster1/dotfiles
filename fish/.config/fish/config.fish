if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

fish_add_path ~/.local/bin ~/.local/share/smgo-manager ~/go/bin /opt/rider/bin/

set -x DOTNET_ROOT /usr/lib64/dotnet
set -x PATH $DOTNET_ROOT $PATH
