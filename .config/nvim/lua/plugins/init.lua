return {
  {
    "iagorrr/noctishc.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme noctishc]])
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#2a2a2a", bg = "NONE" })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#2a2a2a", bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#2a2a2a", bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#2a2a2a", bg = "NONE" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 30,
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
          follow_current_file = {
            enabled = true,
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "gopls", "pyright", "rust_analyzer", "clangd", "elixirls" }, 
      })
      local cmp = require("cmp")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }),
      })

      local servers = { "lua_ls", "gopls", "pyright", "rust_analyzer", "clangd", "elixirls" }
      
      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
          capabilities = capabilities,
        })
        vim.lsp.enable(lsp)
      end
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 65,
        open_mapping = [[<C-\>]],
        direction = "vertical",
        shade_terminals = true,
        start_in_insert = true,
      })
        vim.api.nvim_create_autocmd("TermOpen", {
            callback = function()
                vim.opt_local.statusline = " " 
            end, 
      })
    end,
  },
}
