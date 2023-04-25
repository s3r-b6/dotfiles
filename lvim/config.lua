--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"

-- vim.wo.number = true
vim.opt.number = true
vim.opt.relativenumber = true

-- keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash", "c", "javascript", "json", "lua",
  "python", "typescript", "tsx", "css",
  "rust", "java", "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.plugins = {
  { "unblevable/quick-scope" }, {
  "nacro90/numb.nvim",
  event = "BufRead",
  config = function()
    require("numb").setup {
      show_numbers = true,         -- Enable 'number' for the window while peeking
      show_cursorline = true,      -- Enable 'cursorline' for the window while peeking
      hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
      number_only = false,         -- Peek only when the command is only a number instead of when it starts with a number
      centered_peeking = true,     -- Peeked line will be centered relative to window
    }
  end,
}, {
  "folke/todo-comments.nvim",
  event = "BufRead",
  config = function()
    require("todo-comments").setup()
  end,
},
}
vim.cmd [[
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
]]
