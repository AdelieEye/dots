{ ... }:

{
    programs.bash = {
        enable = true;
        shellAliases = {
            tx  = "tmux";
            jk  = "nvim";
            jkf = "source $HOME/dots/dotfiles/scripts/jkf.sh";
            t   = "tmux popup";
            sl  = "swaylock -c 000000";
            z   = "zathura --fork";
            diff = "colordiff -y";
            mk = "mkdir \"$(date +%F)\"";
            ck = "cd \"$(date +%F)\"";

            "."  = "cd ..";
            ".." = "cd ../..";

            nrs = "sudo nixos-rebuild switch --flake /home/_adelie/dots/#adelie";
            nixclean = "nix-collect-garbage --delete-older-than 10d";
        };

        initExtra = ''
            stty -ixon
            export EDITOR=nvim
            export SUDO_EDITOR=nvim
            eval "$(devenv hook bash)"
            '';
    };
}
