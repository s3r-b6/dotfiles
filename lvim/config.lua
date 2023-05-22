-- general `lvim` is the global options object
lvim.log.level = 'warn'
lvim.transparent_window = true
lvim.format_on_save.enabled = false
lvim.colorscheme = 'lunar'

-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true

-- general
lvim.log.level = 'info'

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = 'space'
lvim.keys.normal_mode['<C-s>'] = ':w<cr>'
lvim.keys.normal_mode['<leader>w'] = ''

-- Copy to clipboard
lvim.keys.visual_mode['<leader>y'] = '"+y'
lvim.keys.normal_mode['<leader>Y'] = '"+yg_'
lvim.keys.normal_mode['<leader>y'] = '"+y'
lvim.keys.normal_mode['<leader>yy'] = '"+yy'


-- Paste from clipboard
lvim.keys.normal_mode['<leader>p'] = '"+p'
lvim.keys.normal_mode['<leader>P'] = '"+P'
lvim.keys.visual_mode['<leader>p'] = '"+p'
lvim.keys.visual_mode['<leader>P'] = '"+P'

-- VimWiki
lvim.keys.normal_mode['<leader>w'] = ''

lvim.keys.normal_mode['<leader>u'] = vim.cmd.UndotreeToggle

lvim.colorscheme = 'lunar'

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = 'dashboard'
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = 'left'
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ignore_install = { 'haskell' }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
    'bash', 'c', 'javascript', 'json', 'lua',
    'python', 'typescript', 'tsx', 'css',
    'rust', 'java', 'yaml', 'sql'
}
-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        name = "prettier",
        args = { "--tab-width", "4" },
    },
}


-- skip lsp config for jdtls, let nvim-jdtls handle it
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

lvim.plugins = {
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup {
                'css',
                'javascript',
                html = { mode = 'foreground', }
            }
        end,
    },
    { 'unblevable/quick-scope' },
    {
        'nacro90/numb.nvim',
        event = 'BufRead',
        config = function()
            require('numb').setup {
                show_numbers = true,         -- Enable 'number' for the window while peeking
                show_cursorline = true,      -- Enable 'cursorline' for the window while peeking
                hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
                number_only = false,         -- Peek only when the command is only a number instead of when it starts with a number
                centered_peeking = true,     -- Peeked line will be centered relative to window
            }
        end,
    },
    { 'tpope/vim-surround' },       -- change/add surroundings
    { 'mbbill/undotree' },          -- undotree
    {
        'folke/todo-comments.nvim', --highlight and search todos
        event = 'BufRead',
        config = function()
            require('todo-comments').setup()
        end,
    },
    {
        'mfussenegger/nvim-jdtls', --config for jdtls
        ft = "java",
        config = function()
            local on_attach = function(client, bufnr)
                require("lazyvim.plugins.lsp.keymaps").on_attach(client, bufnr)
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            -- calculate workspace dir
            local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
            -- get the mason install path
            local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
            -- local debug_install_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
            local config = {
                cmd = {
                    install_path .. "/bin/jdtls",
                    "--jvm-arg=-javaagent:" .. install_path .. "/lombok.jar",
                    "-data",
                    workspace_dir,
                },
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = vim.fs.dirname(
                    vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }, { upward = true })[1]
                ),
            }
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    require("jdtls").start_or_attach(config)
                end,
            })
        end,
    },
    { 'vimwiki/vimwiki' },
    { 'tpope/vim-dadbod' },
    { 'kristijanhusak/vim-dadbod-ui' }
}

vim.cmd [[
    let g:dbs = {
    \  'dev': 'mysql://root:1234@localhost:3306/'
    \ }

    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    let g:db_ui_use_nerd_fonts = 1
    set nocompatible
    filetype plugin on
    syntax on
]]
