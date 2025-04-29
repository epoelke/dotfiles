_G.myfolds = {
  nft_fold_expr = function(lnum)
    local line = vim.fn.getline(lnum)

    if line:match("^%s*table%s+.-{$") then
      return ">1"
    elseif line:match("^%s*chain%s+.-{$") then
      return ">2"
    elseif line:match("^%s*set%s+.-{$") then
      return ">2"
    elseif line:match("^%s*map%s+.-{$") then
      return ">2"
    elseif line:match("^%s*flowtable%s+.-{$") then
      return ">2"
    elseif line:match("^{") then
      return ">3"
    elseif line:match("^}") then
      return "<3"
    else
      return "="
    end
  end,
  nft_fold_text = function()
    local first_line = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart
    return first_line .. " ... (" .. line_count .. " lines)"
  end,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nft",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.myfolds.nft_fold_expr(v:lnum)"
    vim.opt_local.foldtext = "v:lua.myfolds.nft_fold_text()"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
  end,
})
