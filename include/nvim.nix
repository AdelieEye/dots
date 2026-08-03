{ pkgs, unstable, ... }:

{
    programs.neovim = {
        enable = true;
        package = unstable.neovim-unwrapped;
        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        initLua = builtins.readFile ../dotfiles/nvim/init.lua;

        extraPackages = with pkgs; [
            lua-language-server
            nixd
            clang-tools
            bash-language-server
            vscode-css-languageserver
            superhtml
            typescript-language-server
            tinymist
            vscode-json-languageserver
            basedpyright
        ];

        plugins = [
            (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ 
                  p.c 
                  p.cpp
                  p.nix
                  p.lua
                  p.javascript
                  p.typescript
                  p.hurl
            ]))
        ];

    };
}
