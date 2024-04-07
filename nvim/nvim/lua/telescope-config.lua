-- Config diagnostics
local open_with_trouble = require("trouble.sources.telescope").open

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
require('telescope').setup {
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = {
        ['<C-u>'] = false,
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<C-t>"] = open_with_trouble,
        ["<C-p>"] = action_layout.toggle_preview,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-t>"] = open_with_trouble,
        ["<C-p>"] = action_layout.toggle_preview,
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
      additional_args = { "--ignore-case" },
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})



-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fG', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>lb', require('telescope.builtin').buffers, { desc = 'Search [B]uffers' })
vim.keymap.set('n', '<leader>lc', require('telescope.builtin').command_history, { desc = 'Search history [C]omands' })
vim.keymap.set('n', '<leader>ls', require('telescope.builtin').search_history, { desc = 'Search history [S]earch' })
vim.keymap.set('n', '<leader>lr', require('telescope.builtin').registers, { desc = 'Search [R]gisters' })
vim.keymap.set('n', '<leader>lk', require('telescope.builtin').keymaps, { desc = 'Search [K]ey mappings' })
vim.keymap.set('n', '<leader>lC', require('telescope.builtin').colorscheme, { desc = 'Search [C]olorscheme' })

vim.keymap.set('n', '<leader>lh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>lG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>le', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>lr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
