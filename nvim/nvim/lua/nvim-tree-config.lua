require("nvim-web-devicons").setup()

local api = require "nvim-tree.api"

local function opts(desc)
  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

vim.keymap.set('n', '<leader>tu', api.tree.change_root_to_parent, opts('Up'))
vim.keymap.set('n', '<leader>th', api.tree.toggle_help, opts('Help'))
vim.keymap.set('n', '<leader>to', api.tree.focus, opts('open or focus'))
vim.keymap.set('n', '<leader>tt', api.tree.toggle, opts('toggle open or close'))


local function nvim_tree_on_attach(bufnr)
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'ta', api.fs.create, opts('Create File Or Directory'))
  vim.keymap.set('n', 'td', api.fs.remove, opts('Delete file or Directory'))

  vim.keymap.set('n', 't-', api.tree.collapse_all, opts('Collapse the tree'))
  vim.keymap.set('n', 't+', api.tree.expand_all, opts('Expand the tree'))

  vim.keymap.set('n', 'ts', api.tree.search_node, opts('Search node'))
  vim.keymap.set('n', 't>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 't<', api.node.navigate.sibling.prev, opts('Prev Sibling'))
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = nvim_tree_on_attach,
})
