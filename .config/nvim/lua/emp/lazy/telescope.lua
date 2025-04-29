return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>sf",      "<cmd>Telescope git_files<cr>",                     desc = "Find Files (root dir)" },
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",                    desc = "Find Files (current dir)" },
      { "<leader><space>", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers" },
      { "<leader>sg",      "<cmd>Telescope live_grep<cr>",                     desc = "Search Project" },
      { "<leader>ss",      "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Search Document Symbols" },
      { "<leader>sw",      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search Workspace Symbols" },
      { "<leader>sr",      "<cmd>Telescope lsp_references<cr>",                desc = "Find symbol references" },
    },
    opts = {
      pickers = {
        lsp_document_symbols = {
          symbol_width = 60,    -- Increase this value to make the signature column wider
          layout_config = {
            width = 0.8,        -- 80% of screen width
            preview_width = 0.5 -- Preview takes 50% of the telescope window
          },
          find_files = {
            hidden = true -- Show hidden files too
          }
        },
        live_grep = {
          additional_args = function()
            return {
              "--glob", "!build/**",
              "--glob", "!dist/**",
              "--glob", "!vendor/**",
              "--glob", "!docs/**"
            }
          end,
        },
        lsp_dynamic_workspace_symbols = {
          symbol_width = 60, -- Also apply to workspace symbols
          layout_config = {
            width = 0.8,
            preview_width = 0.5
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        }
      }
    }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require('telescope').load_extension('fzf')
    end
  },
}
