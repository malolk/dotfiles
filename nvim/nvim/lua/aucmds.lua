-- augroups
vim.cmd([[
  augroup TrimWhitespace
  autocmd BufWritePre * :%s/\s\+$//e
  augroup END
]])
