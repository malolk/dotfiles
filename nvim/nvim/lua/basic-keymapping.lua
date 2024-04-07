-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clipboard
-- vim.keymap.set({'n', 'v', 'i'}, '<C-C>', '"*y')
vim.keymap.set('n', '<leader>y', '<Plug>OSCYankOperator', {desc = 'use like yank'})
-- vim.keymap.set('n', '<leader>y', '<leader>y_', { remap = true })
vim.keymap.set('v', '<leader>y', '<Plug>OSCYankVisual', {desc = 'into visual mode and yank'})

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- pinky keymaps
vim.keymap.set('n', '<C-S>', ':w<CR>', { silent = true })
vim.keymap.set('n', '<C-Q>', ':q<CR>', { silent = true })

-- source files
vim.keymap.set('n', '<leader>ld', ':w | source %<CR>', { silent = true, desc = 'save and source' })

-- cancel highlight
vim.keymap.set('n', '<leader>nh', ':noh<CR>', { silent = true, desc = 'cancel highlight' })

-- buffers
vim.keymap.set('n', '<C-w>b', ':bnext<CR>', { silent = true, desc = 'next buffer' })
vim.keymap.set('n', '<C-w>B', ':bprev<CR>', { silent = true, desc = 'first buffer' })

-- tabs
vim.keymap.set('n', '<leader>a', 'gt', { silent = true })
vim.keymap.set('n', ';f', ':Format<CR>', { silent = true })
vim.keymap.set('n', '<leader>t[', ':tabmove -1<CR>', { silent = true })
vim.keymap.set('n', '<leader>t]', ':tabmove +1<CR>', { silent = true })
vim.keymap.set('n', '<leader>1', '1gt', { silent = true })
vim.keymap.set('n', '<leader>2', '2gt', { silent = true })
vim.keymap.set('n', '<leader>3', '3gt', { silent = true })
vim.keymap.set('n', '<leader>4', '4gt', { silent = true })
vim.keymap.set('n', '<leader>5', '5gt', { silent = true })
vim.keymap.set('n', '<leader>6', '6gt', { silent = true })
vim.keymap.set('n', '<leader>7', '7gt', { silent = true })
vim.keymap.set('n', '<leader>8', '8gt', { silent = true })
vim.keymap.set('n', '<leader>9', '9gt', { silent = true })
vim.keymap.set('n', '<leader>0', ':tablast<CR>', { silent = true })
vim.keymap.set('n', '<ESC>', '<ESC><CR><ESC>', { silent = true })

-- lazy
vim.keymap.set('n', '<leader>lz', ':Lazy<CR>', { silent = true })
-- lsLLp
vim.keymap.set('n', '<leader>li', ':LspInfo<CR>', { silent = true })


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
