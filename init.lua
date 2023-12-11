vim = vim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--Standard configuration
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.wo.colorcolumn = '80'
--Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" }, -- For luasnip users.
        -- { name = "orgmode" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end
}

local tokyo_night =  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}

local conjure ={
  "Olical/conjure",
  ft = { "clojure", "fennel", "python" }, -- etc
  -- [Optional] cmp-conjure for cmp
  dependencies = {
    {
      "PaterJason/cmp-conjure",
      config = function()
        local cmp = require("cmp")
        local config = cmp.get_config()
        table.insert(config.sources, {
          name = "buffer",
          option = {
            sources = {
              { name = "conjure" },
            },
          },
        })
        cmp.setup(config)
      end,
    },
  },
  config = function(_, opts)
    require("conjure.main").main()
    require("conjure.mapping")["on-filetype"]()
  end,
  --init = function()
    -- Set configuration options here
    --  vim.g["conjure#debug"] = true
    --end,
  }
  local nerdtree = {"preservim/nerdtree"}


  local lspconfig = {
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconf = require("lspconfig")
      lspconf.lua_ls.setup {}
      lspconf.clojure_lsp.setup {}
      lspconf.hls.setup {}
      lspconf.clangd.setup {}
      lspconf.zls.setup {}
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      config = function ()
        local configs = require("mason-lspconfig")
        configs.setup({
          ensure_installed = { "lua_ls", "clangd", "bashls",
          "clojure_lsp", "java_language_server",
          "html", "unocss", "tsserver",
          "dockerls",
          "pylsp",
          "hls", --Haskell
          "zls"
        }
      }
      )
    end,
    dependencies = {
      "williamboman/mason.nvim",
      config = function ()
        local configs = require("mason")
        configs.setup(
        {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            }
          }
        }
        )
      end,
    }
  }
}


local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup(
    {
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query", --Should always be installed
        "javascript", "html", "css", --Web base
        "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", --Git stuff
        "dockerfile", "terraform", "yaml", "cmake", "diff", --Sysadminy stuff
        "clojure", "java", "kotlin", "scala", --JVM languages
        "python", "bash", "ruby", "rust", "cpp", -- Common languages
        "csv", "tsv", "latex", "markdown", -- Data language
        "haskell_persistent", "elixir", "elm", "erlang", "scheme", "zig", --Maybe I will touch these one day?
      },
      sync_install = false,
      highlight = {enable = true,
      additional_vim_regex_highlighting = false },
      indent = { enable = false },
      ignore_install = {},
      auto_install = true,
      modules = {}
    }
    )
  end
}

local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = {"nvim-tree/nvim-web-devicons",
  config = function ()
    local configs = require("lualine")
    configs.setup(
    {
      options = { theme = "tokyonight", },
    }
    )
  end
}
}

local autoclose = {
  'm4xshen/autoclose.nvim',
  config = function ()
    local configs = require('autoclose')
    configs.setup(
    {
      keys = {
        ["'"] = { escape = false, close = false, pair = "''" },
        ["`"] = { escape = false, close = false, pair = "``" },
      }
    }
    )
  end
}

local telescope = {
  'nvim-telescope/telescope.nvim', --tag = '0.1.3',
  dependencies = {
    'nvim-lua/plenary.nvim', 
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function ()
    local configs = require('telescope')
    configs.setup(
    {
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      },
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "Library"
        }
      }
    }
    )
    configs.load_extension('fzf')
  end
}

local parinfer = {
  "gpanders/nvim-parinfer"
}

local paredit = {
  "julienvincent/nvim-paredit",
  config = function()
    local paredit = require("nvim-paredit")
    paredit.setup({
      -- should plugin use default keybindings? (default = true)
      use_default_keys = true,
      -- sometimes user wants to restrict plugin to certain file types only
      -- defaults to all supported file types including custom lang
      -- extensions (see next section)
      filetypes = { "clojure" },

      -- This controls where the cursor is placed when performing slurp/barf operations
      --
      -- - "remain" - It will never change the cursor position, keeping it in the same place
      -- - "follow" - It will always place the cursor on the form edge that was moved
      -- - "auto"   - A combination of remain and follow, it will try keep the cursor in the original position
      --              unless doing so would result in the cursor no longer being within the original form. In
      --              this case it will place the cursor on the moved edge
      cursor_behaviour = "auto", -- remain, follow, auto

      indent = {
        -- This controls how nvim-paredit handles indentation when performing operations which
        -- should change the indentation of the form (such as when slurping or barfing).
        --
        -- When set to true then it will attempt to fix the indentation of nodes operated on.
        enabled = false,
        -- A function that will be called after a slurp/barf if you want to provide a custom indentation
        -- implementation.
        indentor = require("nvim-paredit.indentation.native").indentor,
      },

      -- list of default keybindings
      keys = {
        [">)"] = { paredit.api.slurp_forwards, "Slurp forwards" },
        [">("] = { paredit.api.barf_backwards, "Barf backwards" },

        ["<)"] = { paredit.api.barf_forwards, "Barf forwards" },
        ["<("] = { paredit.api.slurp_backwards, "Slurp backwards" },

        [">e"] = { paredit.api.drag_element_forwards, "Drag element right" },
        ["<e"] = { paredit.api.drag_element_backwards, "Drag element left" },

        [">f"] = { paredit.api.drag_form_forwards, "Drag form right" },
        ["<f"] = { paredit.api.drag_form_backwards, "Drag form left" },

        ["<localleader>o"] = { paredit.api.raise_form, "Raise form" },
        ["<localleader>O"] = { paredit.api.raise_element, "Raise element" },

        ["E"] = {
          paredit.api.move_to_next_element_tail,
          "Jump to next element tail",
          -- by default all keybindings are dot repeatable
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },
        ["W"] = {
          paredit.api.move_to_next_element_head,
          "Jump to next element head",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },

        ["B"] = {
          paredit.api.move_to_prev_element_head,
          "Jump to previous element head",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },
        ["gE"] = {
          paredit.api.move_to_prev_element_tail,
          "Jump to previous element tail",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },

        ["("] = {
          paredit.api.move_to_parent_form_start,
          "Jump to parent form's head",
          repeatable = false,
          mode = { "n", "x", "v" },
        },
        [")"] = {
          paredit.api.move_to_parent_form_end,
          "Jump to parent form's tail",
          repeatable = false,
          mode = { "n", "x", "v" },
        },

        -- These are text object selection keybindings which can used with standard `d, y, c`, `v`
        ["af"] = {
          paredit.api.select_around_form,
          "Around form",
          repeatable = false,
          mode = { "o", "v" }
        },
        ["if"] = {
          paredit.api.select_in_form,
          "In form",
          repeatable = false,
          mode = { "o", "v" }
        },
        ["aF"] = {
          paredit.api.select_around_top_level_form,
          "Around top level form",
          repeatable = false,
          mode = { "o", "v" }
        },
        ["iF"] = {
          paredit.api.select_in_top_level_form,
          "In top level form",
          repeatable = false,
          mode = { "o", "v" }
        },
        ["ae"] = {
          paredit.api.select_element,
          "Around element",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["ie"] = {
          paredit.api.select_element,
          "Element",
          repeatable = false,
          mode = { "o", "v" },
        },
      }
    })
  end
}

local plugins = {
  tokyo_night,
  nvim_cmp,
  conjure,
  lspconfig,
  treesitter,
  lualine,
  autoclose,
  telescope,
  parinfer,
  paredit,
}

require("lazy").setup(plugins, {})

--Plugin dependent configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true

vim.cmd[[colorscheme tokyonight-night]]

vim.keymap.set('n', '<Leader>n', ":NERDTreeFocus<return>", {noremap=true})


--AU commands
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autoCommands = {
  -- other autocommands
  open_folds = {
    {"BufReadPost,FileReadPost", "*", "normal zR"}
  }
}

M.nvim_create_augroups(autoCommands)

--- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <Leader>c
    vim.keymap.set('i', '<Leader>c', '<C-x><C-o>', {noremap=true})
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


