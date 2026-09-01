{ pkgs, zen-browser, ... }:

{
    home.packages = with pkgs; [

        bat
        bat-extras.batgrep
        bat-extras.batman
        btop
        caligula
        colordiff
        devenv
        entr
        fastfetch
        fd
        ffmpeg
        figlet
        gimp
        gnumake
        libnotify
        man-pages
        moreutils
        parallel
        pass
        presenterm
        ripgrep
        secretspec
        swaybg
        tmux
        tree
        typst
        waybar
        wiremix
        yt-dlp

        (dmenu.override {
             patches = [
                 ./patches/fuzzy.diff
             ];
         })

        zen-browser.packages.${pkgs.system}.default
    ];
}
