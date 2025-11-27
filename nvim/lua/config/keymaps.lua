local utils = require('config.utils')
local map = utils.map
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap
local picker = utils.snacks_picker

local ok, local_config = pcall(require, 'config.local')
if not ok then
  local_config = {
    octo = {
      repo = "COMPANY/REPO",
      project_prefix = "PROJECT-",
    }
  }
end

-- Completion keymaps
vim.cmd([[inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"]])
imap('<C-j>', [[pumvisible() ? "<C-n>" : "<C-j>"]], { desc = "Remaps C-j to C-n", expr = true, noremap = false })
imap('<C-k>', [[pumvisible() ? "<C-p>" : "<C-k>"]], { desc = "Remaps C-k to C-p", expr = true, noremap = false })

-- Clipboard
vmap('<leader>y', '"+y', { desc = "Copy to clipboard the selection" })
nmap('<leader>Y', '"+yg_', { desc = "Copy to clipboard until end of line" })
nmap('<leader>yy', '"+yy', { desc = "Copy to clipboard whole line" })
nmap('<leader>p', '"+p', { desc = "Paste from clipboard" })
nmap('<leader>P', '"+P', { desc = "Paste from clipboard" })
vmap('<leader>p', '"+p', { desc = "Paste from clipboard" })
vmap('<leader>P', '"+P', { desc = "Paste from clipboard" })

-- UndoTree
nmap('<leader>u', ':UndotreeToggle<CR>', { desc = "Toggle UndoTree" })

-- Word wrap navigation
nmap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Picker/Search keymaps
nmap('<leader><space>', picker('buffers'), { desc = '[S]earch [b]uffers' })
nmap('<leader>sc', picker('lines'), { desc = '[S]earch in [C]urrent buffer' })
nmap('<leader>sf', picker('files'), { desc = '[S]earch [F]iles' })
nmap('<leader>sh', picker('help'), { desc = '[S]earch [H]elp' })
nmap('<leader>sw', picker('grep_word'), { desc = '[S]earch current [W]ord' })
nmap('<leader>sg', picker('grep'), { desc = '[S]earch by [G]rep' })
nmap('<leader>sd', picker('diagnostics'), { desc = '[S]earch [D]iagnostics' })
nmap('<leader>st', picker('todo_comments'), { desc = '[S]earch [T]odos' })
nmap('<leader>so', picker('recent'), { desc = '[S]earch [O]ldfiles' })

-- File explorer and formatting
nmap('gx', ":silent execute '!open ' shellescape(expand('<cfile>'), v:true)<CR>", { desc = 'Open link' })
nmap('<leader>lf', vim.lsp.buf.format, { desc = 'Format the buffer' })
nmap('<leader>le', ":Oil<CR>", { desc = 'Open Oil file explorer' })

-- Git stuff
nmap("<leader>gcx", ":GitBlameOpenCommitURL<CR>", { desc = "Open commit in browser" })
nmap("<leader>gfx", ":GitBlameOpenFileURL<CR>", { desc = "Open file in browser" })

local gitsigns = require('gitsigns')
nmap(']g', function()
	if vim.wo.diff then
		vim.cmd.normal({ ']g', bang = true })
	else
		gitsigns.nav_hunk('next')
	end
end, { desc = "Next hunk" })

nmap('[g', function()
	if vim.wo.diff then
		vim.cmd.normal({ '[g', bang = true })
	else
		gitsigns.nav_hunk('prev')
	end
end, { desc = "Previous hunk" })

-- Actions
nmap('<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
local stageHunk = function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
vmap('<leader>hs', stageHunk, { desc = "Stage selected" })

nmap('<leader>hR', gitsigns.reset_hunk, { desc = "Reset hunk" })
local resetHunk = function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
vmap('<leader>hR', resetHunk, { desc = "Reset selected" })

nmap('<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
nmap('<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
nmap('<leader>hi', gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

nmap('<leader>hb', function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" })
nmap('<leader>hd', gitsigns.diffthis, { desc = "Diff this" })
nmap('<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Diff this ~" })
nmap('<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "All hunks to qflist" })
nmap('<leader>hq', gitsigns.setqflist, { desc = "Buffer hunks to qflist" })
-- Toggles
nmap('<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
nmap('<leader>tw', gitsigns.toggle_word_diff, { desc = "Toggle word diff" })
-- Text object
map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = "Select hunk" })


local neogit = require('neogit')
nmap("<leader>gs", neogit.open, { desc = "Open Neogit" })
nmap("<leader>gc", ":Neogit commit<CR>", { desc = "Neogit commit" })
nmap("<leader>gp", ":Neogit pull<CR>", { desc = "Neogit pull" })
nmap("<leader>gP", ":Neogit push<CR>", { desc = "Neogit push" })

-- UI enhancement keymaps
nmap("<leader>da", Snacks.dim.enable, { desc = "Dim inactive scopes activate" })
nmap("<leader>dd", Snacks.dim.disable, { desc = "Dim inactive scopes deactivate" })

nmap("<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
nmap("<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

nmap("<leader>PRR", string.format(':Octo search "[%s" in:title repo:%s is:open<CR>', local_config.octo.project_prefix, local_config.octo.repo), { desc = "PR Review" })

-- Diagnostic keymaps
nmap('[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
nmap(']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
nmap('<leader>k', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
