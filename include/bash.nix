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
            link= "source $HOME/dots/dotfiles/scripts/link.sh";
            diff= "colordiff -y";
            mk =  "mkdir -p \"$(date +%F)\"";
            ck =  "cd \"$(date +%F)\"";

            "."  = "cd ..";
            ".." = "cd ../..";

            nrs = "sudo nixos-rebuild switch --flake /home/_adelie/dots/#adelie";
            nup = "sudo nix flake update";
            nixclean = "nix-collect-garbage -d";
        };

        initExtra = ''
            stty -ixon
            export EDITOR=nvim
            export SUDO_EDITOR=nvim
            '';
    };
}
