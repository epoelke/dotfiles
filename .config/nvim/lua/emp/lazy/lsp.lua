return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        {
          -- Customize or remove this keymap to your liking
          "<leader>fo",
          function()
            require("conform").format({ async = true })
          end,
          mode = "",
          desc = "Format buffer",
        },
      },
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    require("conform").setup({
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        else
          return {
            timeout_ms = 500,
            lsp_format = "first",
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        javascript = { "prettierd", stop_after_first = true },
        typescript = { "prettierd", stop_after_first = true },
        markdown = { "prettierd", stop_after_first = true },
        graphql = { "prettierd" },
      }
    })
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "pylsp",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        pylsp = function()
          local lspconfig = require("lspconfig")
          lspconfig.pylsp.setup {
            -- cmd = {"pylsp", "-vvv", "--log-file", "/tmp/lsp.log"},
            settings = {
              pylsp = {
                configurationSources = { "ruff" },
                plugins = {
                  ruff = {
                    enabled = true,
                    formatEnabled = true,
                    config = "",
                    lineLength = 100,
                    --select = { "E", "F", "I" },
                    ignore = {},
                    preview = false,
                  },
                  pylsp_mypy = { enabled = true },
                  black = { enabled = false },
                  autopep8 = { enabled = false },
                  yapf = { enabled = false },
                  mccabe = { enabled = false },
                  pycodestyle = { enabled = false },
                  pylsp_rope = { enabled = true },
                  pyflakes = { enabled = false }
                }
              }
            }
          }
        end,
        gopls = function()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup({
            settings = {
              gopls = {
                templateExtensions = { ".gotmpl", ".tmpl" },
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            }
          })
        end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
