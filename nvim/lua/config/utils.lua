local M = {}

-- Helper function to create keymaps with consistent defaults
function M.map(mode, lhs, rhs, opts)
	opts = opts or {}
	-- Set common defaults
	local default_opts = {
		silent = true,
		noremap = true,
	}
	-- Merge user opts with defaults
	opts = vim.tbl_extend('force', default_opts, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Convenience functions for different modes
function M.nmap(lhs, rhs, opts)
	M.map('n', lhs, rhs, opts)
end

function M.vmap(lhs, rhs, opts)
	M.map('v', lhs, rhs, opts)
end

function M.imap(lhs, rhs, opts)
	M.map('i', lhs, rhs, opts)
end

-- Helper for Snacks picker functions
function M.snacks_picker(picker_fn, cwd)
	return function()
		if cwd then
			Snacks.picker[picker_fn]({ cwd = cwd })
		else
			Snacks.picker[picker_fn]()
		end
	end
end

return M