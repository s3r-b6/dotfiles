-- Kulala mappings
vim.api.nvim_set_keymap("n", ",j", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",k", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",r", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
