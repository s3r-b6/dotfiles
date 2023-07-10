local function setup_keys()
	-- Go back, go forth
	vim.keymap.set('n', "gb", "<C-O>")
	vim.keymap.set('n', "gn", "<C-I>")
	-- Ignores
	vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
	vim.keymap.set('n', "<leader>q", "<Nop>")
	-- Fast edit config
	vim.keymap.set('n', '<leader>Lc', ':e ~/.config/nvim/init.lua<CR>', { desc = "Edit the config" })
	-- Copy to clipboard
	vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy to clipboard the selection" })
	vim.keymap.set('n', '<leader>Y', '"+yg_', { desc = "Copy to clipboard until end of line" })
	vim.keymap.set('n', '<leader>yy', '"+yy', { desc = "Copy to clipboard whole line" })
	-- Paste from clipboard
	vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from clipboard" })
	vim.keymap.set('n', '<leader>P', '"+P', { desc = "Paste from clipboard" })
	vim.keymap.set('v', '<leader>p', '"+p', { desc = "Paste from clipboard" })
	vim.keymap.set('v', '<leader>P', '"+P', { desc = "Paste from clipboard" })
	-- Quit
	vim.keymap.set('n', "<leader>bq", ":q<CR>")
	-- Splits
	vim.keymap.set('n', "<leader>bor", ":vsplit<CR>", { desc = "Open a vertical split" })
	vim.keymap.set('n', "<leader>bod", ":split<CR>", { desc = "Open a horizontal split" })
	vim.keymap.set('n', "<leader>b=", "<C-W>=", { desc = "Make all windows equal" })
	-- Newline
	vim.keymap.set('n', '[ ', 'O<ESC>')
	vim.keymap.set('n', '] ', 'o<ESC>')
	-- Errors
	vim.keymap.set('n', '[q', ':cprevious<CR>')
	vim.keymap.set('n', ']q', ':cnext<CR>')
	-- Move between windows
	vim.keymap.set('n', '<C-h>', '<C-W>h')
	vim.keymap.set('n', '<C-l>', '<C-W>l')
	vim.keymap.set('n', '<C-j>', '<C-W>j')
	vim.keymap.set('n', '<C-k>', '<C-W>k')
	-- LazyGit
	vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>')
	-- UndoTree
	vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
	-- Tabs
	vim.keymap.set('n', '<leader>tC', ':tabonly<CR>')
	vim.keymap.set('n', '<leader>tc', ':tabclose<CR>')
	vim.keymap.set('n', '<leader>bn', ':tabnext<CR>')
	vim.keymap.set('n', '<leader>bb', ':tabprevious<CR>')
	-- Remap for dealing with word wrap
	vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	-- Diagnostic keymaps
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
	vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

	vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = '[F]ile [E]xplorer', silent = true })

	-- [Plugins mappings] See `:help telescope.builtin`
	vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
		{ desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
		{ desc = '[ ] Find existing buffers' })
	vim.keymap.set('n', '<leader>/', function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			winblend = 10,
			previewer = false,
		})
	end, { desc = '[/] Fuzzily search in current buffer' })

	vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
	vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
end

return { setup_keys = setup_keys }
