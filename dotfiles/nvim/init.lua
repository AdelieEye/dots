-- ========================= OPTIONS =========================

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ''
vim.opt.numberwidth = 6
vim.opt.colorcolumn = '90'
vim.opt.undofile = true
vim.opt.breakindent = true
vim.o.cursorline = true
vim.o.scrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.exrc = true;
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.cmdheight = 0
vim.opt.laststatus = 3

vim.opt.shortmess:append("I")
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.winborder = "single"
vim.opt.background = "dark"

vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    extends = "›",
    precedes = "‹",
    nbsp = "␣",
}

-- ========================= _EXTRA_ =========================

--TreeSitter Config
vim.cmd('syntax off')
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        if not pcall(vim.treesitter.start) then
            vim.cmd('syntax enable')
        end
    end,
})

--Yank HL
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end
})

-- ========================= PLUGINS =========================

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({

    gh('Eandrju/cellular-automaton.nvim');
    gh('Wansmer/treesj');
    gh('catgoose/nvim-colorizer.lua'),
    gh('chrisgrieser/nvim-spider');
    gh('folke/flash.nvim');
    gh('godlygeek/tabular');
    gh('hat0uma/csvview.nvim');
    gh('j-hui/fidget.nvim');
    gh('kylechui/nvim-surround');
    gh('lewis6991/gitsigns.nvim');
    gh('neovim/nvim-lspconfig');
    gh('nvim-lualine/lualine.nvim'), --
    gh('nvim-mini/mini.pick');
    gh('sainnhe/gruvbox-material');
    gh('stevearc/quicker.nvim');
    gh('windwp/nvim-autopairs');

    'https://git.sr.ht/~whynothugo/lsp_lines.nvim';
})

--ColorScheme
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

        vim.api.nvim_set_hl(0, "LspInlayHint", {
            link = "Comment",
            italic = true,
        })

        -- vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#A855F7", bg = "none" })
        -- vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
    end,
})

vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_better_performance = 1
vim.cmd.colorscheme('gruvbox-material')

require('vim._core.ui2').enable({})

require('nvim-autopairs').setup({})
require('colorizer').setup({})
require('gitsigns').setup({})
require('fidget').setup({})
require('nvim-surround').setup({})
require('treesj').setup({})
require('csvview').setup({})
require('flash').setup({})

require('lualine').setup({
    options = {
        theme = 'gruvbox-material',
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = {
            {
                function()
                    local reg = vim.fn.reg_recording()
                    return reg ~= "" and ("Recording @" .. reg) or ""
                end
            },
        },
    },
})

require("mini.pick").setup({
    options = {
        content_from_bottom = true,
    },
    window = {
        config = function()
            local height = math.floor(vim.o.lines * 0.25)

            return {
                anchor = "SW",
                relative = "editor",

                row = vim.o.lines - 0, -- bottom of screen
                col = 0,

                width = vim.o.columns,
                height = height,

                border = "none",
                title = "",
            }
        end,
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "csv",
    callback = function()
        vim.cmd('CsvViewEnable')
    end,
})

require("quicker").setup({
  keys = {
    { ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end },
    { "<", function() require("quicker").collapse() end },
  },
})

require("lsp_lines").setup({})
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { only_current_line = true },
    signs = true,
    underline = false,
    severity_sort = true,
    update_in_insert = false,
})

-- ========================= __LSP__ =========================

vim.lsp.enable({
    'lua_ls',
    'nixd',
    'clangd',
    'bashls',
    'cssls',
    'superhtml',
    'ts_ls',
    'denols',
    'tinymist',
    'jsonls',
    'basedpyright',
})

vim.lsp.inlay_hint.enable(false)
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})

-- ========================= KEYMAPS =========================

vim.keymap.set('n', '<Esc>', ':noh<CR>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>w', ':update<CR>')
vim.keymap.set('n', '<leader>x', ':x<CR>')
vim.keymap.set('n', '<leader>t', ':! tmux popup<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>b', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>j', ':TSJToggle<CR>')
vim.keymap.set('n', '<leader>s', ':split<CR>')
vim.keymap.set('n', '<leader>v', ':vsplit<CR>')

vim.keymap.set('i', '<Tab>', '<C-x><C-o>')

vim.keymap.set({ "n", "x", "o" }, "s", function() require('flash').jump() end)
vim.keymap.set({ "n", "x", "o" }, "S", function() require('flash').treesitter() end)
vim.keymap.set("o", "r", function() require('flash').remote() end)

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

vim.keymap.set("n", "<leader>q", function() require("quicker").toggle() end)
vim.keymap.set("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end)

vim.keymap.set({ "n", "o", "x" }, "w",  function() require("spider").motion("w") end)
vim.keymap.set({ "n", "o", "x" }, "e",  function() require("spider").motion("e") end)
vim.keymap.set({ "n", "o", "x" }, "b",  function() require("spider").motion("b") end)
vim.keymap.set({ "n", "o", "x" }, "ge", function() require("spider").motion("ge") end)

vim.keymap.set("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set('n', '<leader>cp', ':r $HOME/template/cp.cpp<CR>')
-- ========================= __END__ =========================
