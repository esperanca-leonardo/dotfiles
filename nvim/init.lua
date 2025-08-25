-- Neovim "estilo VS Code" — init.lua
-- Requisitos no ArchLinux (terminal):
--   sudo pacman -S neovim git pyright jdtls ripgrep unzip
-- (pyright = LSP Python; jdtls = LSP Java)

------------------------------------------------------------
-- Opções básicas
------------------------------------------------------------
local o, wo, bo = vim.o, vim.wo, vim.bo
vim.g.mapleader = " "

o.termguicolors = true
o.number = true
o.relativenumber = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
o.updatetime = 250

------------------------------------------------------------
-- Bootstrap do lazy.nvim (gerenciador de plugins)
------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- Plugins
------------------------------------------------------------
require("lazy").setup({
------------------------------------------------------------
-- Ident Blankline
------------------------------------------------------------
  {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    -- recria os highlights sempre que o tema mudar
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
    end)

    require("ibl").setup({
      indent = { highlight = highlight },
    })
  end,
  },

  ----------------------------------------------------------------
  -- Tema
  ----------------------------------------------------------------
  --{
    --"folke/tokyonight.nvim",
    --lazy = false,
    --priority = 1000,
    --config = function()
      --vim.cmd.colorscheme("tokyonight")
    --end,
  --},
  {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      filter = "pro", -- opções: pro, classic, octagon, machine, ristretto, spectrum
    })
    vim.cmd.colorscheme("monokai-pro")
  end,
  },
  ----------------------------------------------------------------
  -- Ícones (usado por vários plugins)
  ----------------------------------------------------------------
  { "nvim-tree/nvim-web-devicons" },

  ----------------------------------------------------------------
  -- Statusline (barra inferior)
  ----------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto", globalstatus = true },
      })
    end,
  },

  ----------------------------------------------------------------
  -- Barra lateral de arquivos (Explorer)
  ----------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Toggle com <leader>e (barra de espaço + e)
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Explorer" })
      -- Abre na mesma janela por padrão
      require("neo-tree").setup({
        window = { width = 32 },
        filesystem = { follow_current_file = { enabled = true } },
      })
    end,
  },

  ----------------------------------------------------------------
  -- Abas em cima (buffers em estilo tabs)
  ----------------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = { diagnostics = "nvim_lsp", separator_style = "slant" },
      })
      -- Navegação entre abas
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Próxima aba" })
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Aba anterior" })
      vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true, desc = "Fechar aba atual" })
    end,
  },

  ----------------------------------------------------------------
  -- LSP + Autocomplete (Java e Python)
  ----------------------------------------------------------------
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip", version = "*" },

  ----------------------------------------------------------------
  -- Telescope (busca tipo Ctrl+P do VSCode)
  ----------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Buscar arquivos" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep (texto)" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Lista buffers" })
      vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Help tags" })
    end,
  },
})

------------------------------------------------------------
-- Configuração do Autocomplete (nvim-cmp)
------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = "nvim_lsp" },
  },
})

------------------------------------------------------------
-- LSP (Python e Java)
------------------------------------------------------------
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Keymaps LSP gerais (ir para definição, renomear, etc.)
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  map("n", "gd", vim.lsp.buf.definition, "Ir para definição")
  map("n", "gr", vim.lsp.buf.references, "Referências")
  map("n", "K", vim.lsp.buf.hover, "Hover doc")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Renomear símbolo")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Ação de código")
  map("n", "<leader>fd", function() vim.diagnostic.open_float(nil, { focus = false }) end, "Ver diagnósticos")
  map("n", "[d", vim.diagnostic.goto_prev, "Diag anterior")
  map("n", "]d", vim.diagnostic.goto_next, "Próx diag")
end

-- Python (pyright)
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Java (jdtls)
-- Observação: jdtls costuma ser iniciado por projeto; este setup simples atende a maioria dos casos.
lspconfig.jdtls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

------------------------------------------------------------
-- Qualidade de vida
------------------------------------------------------------
-- Salvar com Ctrl+s e fechar com Ctrl+q
vim.keymap.set({"n","i","v"}, "<C-s>", function() vim.cmd("w") end, { desc = "Salvar" })
vim.keymap.set("n", "<C-q>", ":q<CR>", { silent = true, desc = "Fechar janela" })

-- Melhor pesquisa incremental
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Desabilitar espaço sozinho (evita mensagens)
vim.keymap.set({"n","v"}, "<Space>", "<Nop>", { silent = true })

------------------------------------------------------------
-- Dicas de uso rápidas
------------------------------------------------------------
-- <leader>e   = abrir/fechar Explorer (Neo-tree)
-- <Tab> / <S-Tab> = navegar entre abas (bufferline)
-- <leader>f   = buscar arquivos (Telescope)
-- <leader>g   = buscar texto (Telescope live grep)
-- <leader>b   = listar buffers
-- <C-Space>   = abrir menu de autocomplete
-- <leader>rn  = renomear símbolo (LSP)
-- :Lazy sync   = instalar/atualizar plugins

