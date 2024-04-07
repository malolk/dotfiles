return {
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			"p00f/clangd_extensions.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',

			{
				'ray-x/lsp_signature.nvim',
				event = "VeryLazy",
				opts = {},
				config = function(_, opts) require('lsp_signature').setup(opts) end
			},

			{
				"joechrisellis/lsp-format-modifications.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim"
				},
				event = "VeryLazy"
			}
		},
	},
	{
		'ldelossa/litee.nvim',
		dependencies = {
			'ldelossa/litee-calltree.nvim',
		}
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
}
