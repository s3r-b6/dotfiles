return function(_, bufnr)
	vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
	vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
	vim.keymap.set('v', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
	vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
	vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
		{ desc = '[D]ocument [S]ymbols' })
	vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
		{ desc = '[W]orkspace [S]ymbols' })

	-- See `:help K` for why this keymap
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
	--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

	vim.diagnostic.config({
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
		signs = true,
		underline = { severity = vim.diagnostic.severity.ERROR },
		update_in_insert = true,
	})

	-- Dap && dapui
	vim.keymap.set("n", ",do", function() require('dapui').toggle() end, { desc = '[D]AP UI [O]pen' })
	vim.keymap.set("n", ",db", ":DapToggleBreakpoint<CR>", { desc = '[D]AP toggle [B]reakpoint', silent = true })
	vim.keymap.set("n", ",dr", ":DapToggleRepl<CR>", { desc = '[D]AP toggle [R]EPL', silent = true })
	vim.keymap.set("n", ",dc", ":DapContinue<CR>", { desc = '[D]AP [C]ontinue', silent = true })
	vim.keymap.set("n", ",de", ":lua require'dapui'.eval()", { desc = '[D]AP [E]val', silent = true })

	vim.keymap.set("n", "<F10>", ":DapStepOver<CR>", { desc = 'Step over', silent = true })
	vim.keymap.set("n", "<F11>", ":DapStepInto<CR>", { desc = 'Step into', silent = true })
	vim.keymap.set("n", "<F12>", ":DapStepOut<CR>", { desc = 'Step out', silent = true })
end
