if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

fish_add_path ~/.local/bin ~/.local/share/smgo-manager ~/go/bin /opt/rider/bin/ ~/.cargo/bin ~/.opam/default/bin ~/.local/bin/toolbox/bin/

set -x DOTNET_ROOT /usr/lib64/dotnet
set -x PATH $DOTNET_ROOT $PATH

set -x JAVA_HOME /usr/lib64/openjdk-25/

# opam configuration
source /home/misu/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
