local function setup_keys()
	-- Fast edit config
	vim.keymap.set('n', '<leader>Lc', ':e ~/.config/nvim/init.lua<CR>', { desc = "Edit the config" })
	-- Go next, go back
	vim.keymap.set('n', "gn", "<C-I>", { desc = "[G]o [n]ext" })
	vim.keymap.set('n', "gb", "<C-O>", { desc = "[G]o [b]ack" })
	-- Clipboard
	vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy to clipboard the selection" })
	vim.keymap.set('n', '<leader>Y', '"+yg_', { desc = "Copy to clipboard until end of line" })
	vim.keymap.set('n', '<leader>yy', '"+yy', { desc = "Copy to clipboard whole line" })
	vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from clipboard" })
	vim.keymap.set('n', '<leader>P', '"+P', { desc = "Paste from clipboard" })
	vim.keymap.set('v', '<leader>p', '"+p', { desc = "Paste from clipboard" })
	vim.keymap.set('v', '<leader>P', '"+P', { desc = "Paste from clipboard" })
	-- Splits
	vim.keymap.set('n', "<leader>bor", ":vsplit<CR>", { desc = "Open a vertical split" })
	vim.keymap.set('n', "<leader>bod", ":split<CR>", { desc = "Open a horizontal split" })
	vim.keymap.set('n', "<leader>b=", "<C-W>=", { desc = "Make all windows equal" })
	-- Newline
	vim.keymap.set('n', '[ ', 'O<ESC>')
	vim.keymap.set('n', '] ', 'o<ESC>')
	-- LazyGit
	vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>')
	-- UndoTree
	vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
	-- Word wrap
	vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	-- Diagnostic keymaps
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
	vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

	--Telescope maps
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
	vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
	vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
	vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set('n', '<leader>sp', ':Telescope projects<CR>', { desc = '[S]earch [P]rojects' })

	vim.keymap.set('i', '<C-j>', [[pumvisible() ? "<C-n>" : "<C-j>"]], { expr = true, noremap = true })
	vim.keymap.set('i', '<C-k>', [[pumvisible() ? "<C-p>" : "<C-k>"]], { expr = true, noremap = true })
end

return { setup_keys = setup_keys }
