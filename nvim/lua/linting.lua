require('lint').linters_by_ft = {
	-- cpp = { 'cpplint' }
}

vim.cmd([[autocmd BufWritePost * lua require('lint').try_lint()]])
