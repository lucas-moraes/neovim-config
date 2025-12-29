---@diagnostic disable: undefined-global

local root_dir = vim.fs.root(0, { "pyproject.toml", ".git", ".editorconfig" })

local pylsp_settings = {
    pylsp = {
        plugins = {
            black = { enabled = true },
            isort = { enabled = true },
            pycodestyle = { enabled = true },
            pylint = { enabled = false },
        }
    }
}

vim.lsp.start({
  name = "pylsp",
  cmd = { "pylsp" },
  root_dir = root_dir,
  settings = pylsp_settings,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
