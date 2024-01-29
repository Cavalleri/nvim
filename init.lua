-- TODO:
-- Take a look at a python's formatter

-- Install folke/lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Plugin list 
require('lazy').setup({
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
        build = ':TSUpdate'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = true
            },
            'williamboman/mason-lspconfig.nvim'
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
                dependencies = {
                    'rafamadriz/friendly-snippets',
                }
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        }
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd.colorscheme('rose-pine')
        end,
    },
    {
        'numToStr/Comment.nvim',
        lazy = false,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
    },
    {
        'akinsho/toggleterm.nvim',
        event = 'ColorScheme',
        config = function()
            require('toggleterm').setup({
                highlights = require('rose-pine.plugins.toggleterm'),
            })
        end,
    },
    'Vimjas/vim-python-pep8-indent'
})

-- LSP servers configs
local servers = {
    clangd = {},
    lua_ls = {
        Lua = {
            workspace = {checkThirdParty = false},
            telemetry = {enable = false},
            diagnostics = {globals = {'vim'}},
        }
    },
    jedi_language_server = {},
    rust_analyzer = {},
}

-- Plugin configs
local cmp = require('cmp')

local configs = {
    ['nvim-treesitter.configs'] = {
        ensure_installed = {'c', 'lua', 'python', 'query', 'rust', 'vim', 'vimdoc'},
        highlight = {
            enable = true,
        },
        indent = {
            enable = false,
        },
        -- Treesitter's incremental selection keymaps
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<Space>',
                node_incremental = '<Space>',
                node_decremental = '<BS>'
            }
        },
        -- Treesitter's textobjects keymaps
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['ik'] = {query = '@class.inner', desc = 'Select inner class'},
                    ['ak'] = {query = '@class.outer', desc = 'Select class'},
                    ['ic'] = {query = '@conditional.inner', desc = 'Select inner conditional'},
                    ['ac'] = {query = '@conditional.outer', desc = 'Select conditional'},
                    ['if'] = {query = '@function.inner', desc = 'Select inner function'},
                    ['af'] = {query = '@function.outer', desc = 'Select function'},
                    ['il'] = {query = '@loop.inner', desc = 'Select inner loop'},
                    ['al'] = {query = '@loop.outer', desc = 'Select loop'},
                    ['ia'] = {query = '@parameter.inner', desc = 'Select inner argument'},
                    ['aa'] = {query = '@parameter.outer', desc = 'Select a argument'}
                }
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ['<Leader>nk'] = {query = '@class.outer', desc = 'Jump to next class start'},
                    ['<Leader>nc'] = {query = '@conditional.outer', desc = 'Jump to next conditional start'},
                    ['<Leader>nf'] = {query = '@function.outer', desc = 'Jump to next function start'},
                    ['<Leader>nl'] = {query = '@loop.outer', desc = 'Jump to next loop start'},
                    ['<Leader>np'] = {query = '@parameter.outer', desc = 'Jump to next parameter start'}
                },
                goto_next_end = {
                    ['<Leader>Nk'] = {query = '@class.outer', desc = 'Jump to next class end'},
                    ['<Leader>Nc'] = {query = '@conditional.outer', desc = 'Jump to next conditional end'},
                    ['<Leader>Nf'] = {query = '@function.outer', desc = 'Jump to next function end'},
                    ['<Leader>Nl'] = {query = '@loop.outer', desc = 'Jump to next loop end'},
                    ['<Leader>Np'] = {query = '@parameter.outer', desc = 'Jump to next parameter end'}
                },
                goto_previous_start = {
                    ['<Leader>pk'] = {query = '@class.outer', desc = 'Jump to previous class start'},
                    ['<Leader>pc'] = {query = '@conditional.outer', desc = 'Jump to previous conditional start'},
                    ['<Leader>pf'] = {query = '@function.outer', desc = 'Jump to previous function start'},
                    ['<Leader>pl'] = {query = '@loop.outer', desc = 'Jump to previous loop start'},
                    ['<Leader>pp'] = {query = '@parameter.outer', desc = 'Jump to previous parameter start'}
                },
                goto_previous_end = {
                    ['<Leader>Pk'] = {query = '@class.outer', desc = 'Jump to previous class end'},
                    ['<Leader>Pc'] = {query = '@conditional.outer', desc = 'Jump to previous conditional end'},
                    ['<Leader>Pf'] = {query = '@function.outer', desc = 'Jump to previous function end'},
                    ['<Leader>Pl'] = {query = '@loop.outer', desc = 'Jump to previous loop end'},
                    ['<Leader>Pp'] = {query = '@parameter.outer', desc = 'Jump to previous parameter end'}
                }
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<Leader>sp'] = {query = '@parameter.inner', desc = 'Swap parameter with the next'}
                },
                swap_previous = {
                    ['<Leader>Sp'] = {query = '@parameter.inner', desc = 'Swap parameter with the previous'}
                }
            }
        }
    },
    ['telescope'] = {},
    ['mason'] = {},
    ['mason-lspconfig'] = {
        ensure_installed = vim.tbl_keys(servers),
    },
    ['cmp'] = {
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<CR>'] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = false,
                        })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({select = true}),
                c = cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                    })
            }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
        }),
        sources = cmp.config.sources({
            {name = 'nvim_lsp'},
            {name = 'luasnip'},
            {name = 'path'},
        }),
    },
    ['Comment'] = {
        toggler = {
            line = '<Leader>cl',
            block = '<Leader>cb',
        },
        opleader = {
            line = '<Leader>cl',
            block = '<Leader>cb',
        },
        extra = {
            above = '<Leader>cO',
            below = '<Leader>co',
            eol = '<Leader>cA',
        },
    },
    ['nvim-autopairs'] = {},
    ['toggleterm'] = {
        open_mapping = [[<Leader>tt]],
    },
}

for plugin, config in pairs(configs) do
    require(plugin).setup(config)
end

require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip').config.setup()

cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
)

-- Helper function to set keymaps
local function set_keymaps(keymaps)
    for _, keymap in pairs(keymaps) do
        -- https://neovim.io/doc/user/lua.html
        vim.keymap.set(unpack(keymap))
    end
end

-- neovim/nvim-lspconfig and williamboman/mason-lspconfig.nvim configs and LSP related keymaps
local on_attach = function(_, buffer)
    local keymaps = {
        {'n', '<leader>rn', vim.lsp.buf.rename, {buffer = buffer, desc = 'LSP: rename symbol'}},
        {'n', '<leader>gd', require('telescope.builtin').lsp_definitions, {buffer = buffer, desc = 'LSP: go to definition'}},
    }
    set_keymaps(keymaps)
end

require('mason-lspconfig').setup_handlers({
    function(server)
        require('lspconfig')[server].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            on_attach = on_attach,
            settings = servers[server],
            filetypes = (servers[server] or {}).filetypes
        })
    end
})

-- NOTE: Monospace fonts might make symbols very small
local signs = {Error = '', Warn = '󰀪', Hint = '󰌶', Info = ''}

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- Keymaps
local keymaps = {
    -- nvim-telescope/telescope.nvim keymaps
    {'n', '<leader>ff', require('telescope.builtin').find_files, {desc = 'Find files'}},
    {'n', '<leader>lg', require('telescope.builtin').live_grep, {desc = 'Live grep string'}},
    {'n', '<leader>lb', require('telescope.builtin').buffers, {desc = 'List open buffers'}},
    {'n', '<leader>fh', require('telescope.builtin').help_tags, {desc = 'Find help tag'}},
    {'n', '<leader>fk', require('telescope.builtin').keymaps, {desc = 'Find keymaps'}},
    -- Custom keymaps
    {'v', 'J', ":m '>+1<CR>gv=gv", {desc = 'Move selected lines down'}},
    {'v', 'K', ":m '<-2<CR>gv=gv", {desc = 'Move selected lines up'}},
    {{'n', 'v'}, '<Space>', '<Nop>', {desc = 'Disables <Space> in normal and visual modes', silent = true}},
    {'n', '<leader>nd', vim.diagnostic.goto_next, {desc = 'Go to the next diagnostic message'}},
    {'n', '<leader>pd', vim.diagnostic.goto_prev, {desc = 'Go to the previous diagnostic message'}},
}

set_keymaps(keymaps)

-- Options
local options = {
    autoindent = true,
    breakident = true,
    completeopt = 'menuone,noselect',
    -- TODO: modify highlight groups for this option to work with rose-pine
    -- cursorline = true,
    -- cursorlineopt = 'number,line',
    equalalways = true,
    expandtab = true,
    hidden = true, -- Required by akinsho/toggleterm
    hlsearch = false,
    incsearch = true,
    ignorecase = true,
    linebreak = true,
    number = true,
    mouse = '',
    relativenumber = true,
    ruler = true,
    scrolloff = 4,
    signcolumn = 'yes',
    shiftwidth = 4,
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitright = true,
    splitbelow = true,
    statusline = '%<%F %h%m%r%=%(%l/%L, %c%)',
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    wrap = false,
}

for option, value in pairs(options) do
    vim.o[option] = value
end
