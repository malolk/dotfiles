local trouble = require("trouble")
trouble.setup {}

local function map_key(m, lhs, rhs, desc)
	vim.keymap.set(m, lhs, rhs, { desc = desc })
end
local function map_key_list(key_list)
	for _, key in ipairs(key_list) do
		map_key('n', key[1], key[2], key["desc"])
	end
end

local trouble_key_mapping = {
	{
		"<leader>et",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Diagnostics (Trouble)",
	},
	{
		"<leader>eb",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "Buffer Diagnostics (Trouble)",
	},
	{
		"<leader>es",
		"<cmd>Trouble symbols toggle focus=false<cr>",
		desc = "Symbols (Trouble)",
	},
	{
		"<leader>el",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "LSP Definitions / references / ... (Trouble)",
	},
	{
		"<leader>eL",
		"<cmd>Trouble loclist toggle<cr>",
		desc = "Location List (Trouble)",
	},
	{
		"<leader>eq",
		"<cmd>Trouble qflist toggle<cr>",
		desc = "Quickfix List (Trouble)",
	},
}
map_key_list(trouble_key_mapping)


local function get_trouble_state()
	local symbols = trouble.statusline({
		mode = "lsp_document_symbols",
		groups = {},
		title = false,
		filter = { range = true },
		format = "{kind_icon}{symbol.name:Normal}",
	})
	return
	{
		symbols.get,
		cond = symbols.has,
	}
end

local function get_time()
	return {
		'datetime',
		style = 'default'
	}
end

local lualine = require('lualine')
lualine.setup {
	options = {
		icons_enabled = false,
		theme = 'auto',
		component_separators = '|',
		section_separators = '',
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'filename' },
		lualine_c = { 'branch', 'diff', get_trouble_state() },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location', get_time() }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	extensions = { 'quickfix', 'fugitive', 'fzf' }
}
