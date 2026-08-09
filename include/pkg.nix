{ pkgs, zen-browser, ... }:

{
    home.packages = with pkgs; [

        bat
        btop
        caligula
        colordiff
        deno
        devenv
        entr
        fastfetch
        fd
        ffmpeg
        figlet
        gimp
        gnumake
        hurl
        libnotify
        moreutils
        nodejs
        parallel
        pass
        presenterm
        ripgrep
        secretspec
        swaybg
        tealdeer
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
