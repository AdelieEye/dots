{ ... }:

{
    imports = [
        ./include/bash.nix
        ./include/delta.nix
        ./include/git.nix
        ./include/kitty.nix
        ./include/nvim.nix
        ./include/oh-my-posh.nix
        ./include/pkg.nix
        ./include/zathura.nix
        ./include/jj.nix
        ./include/mako.nix
    ];

    home.username = "_adelie";
    home.homeDirectory = "/home/_adelie";
    home.stateVersion = "26.05";
}
