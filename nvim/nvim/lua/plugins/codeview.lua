return {
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	{
		'junegunn/vim-peekaboo',
	},
	{ 'ojroques/vim-oscyank' },

	{
		"folke/trouble.nvim",
		branch = "dev", -- IMPORTANT!
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},

	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
	},

	-- bufferline
	{
		'akinsho/bufferline.nvim',
		version = "*",
		opts = {
			options = {
				mode = "tabs",
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true
			}
		}
	},

	-- move in vim
	'justinmk/vim-sneak',

	-- make f/F fast
	'unblevable/quick-scope'
}
