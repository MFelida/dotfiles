-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- {
  --   'codam-coding-college/codam-header.nvim',
  --   cmd = { 'Stdheader' },
  --   opts = {
  --     default_map = true,
  --     auto_update = true,
  --     user = 'mifelida',
  --     mail = 'mifelida@student.codam.nl',
  --   },
  --   config = function(_, opts)
  --     require('codamheader').setup(opts)
  --   end,
  -- },
  {
    'https://github.com/42Paris/42header',
    cmd = 'Stdheader',
    init = function(_)
      vim.g.user42 = 'mifelida'
      vim.g.mail42 = 'mifelida@student.codam.nl'
    end,
  },
  {
    'kiyoon/jupynium.nvim',
    build = 'conda run --no-capture-output -n jupynium pip install .',
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    ft = { 'python', 'c', 'cpp', 'lua', 'javascript', 'typescript' }, -- Lazy load for these filetypes
    keys = {
      -- Copilot panel commands
      { '<leader>cp', '<cmd>Copilot panel<CR>', desc = '[C]opilot [p]anel', mode = 'n' },
      { '<leader>cs', '<cmd>Copilot status<CR>', desc = '[C]opilot [s]tatus', mode = 'n' },
      { '<leader>ce', '<cmd>Copilot enable<CR>', desc = '[C]opilot [e]nable', mode = 'n' },
      { '<leader>cd', '<cmd>Copilot disable<CR>', desc = '[C]opilot [d]isable', mode = 'n' },
    },
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'right',
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<C-g>', -- Ctrl+g to accept entire suggestion (NOT Tab!)
          accept_word = '<C-f>', -- Ctrl+f to accept word
          accept_line = '<C-l>', -- Ctrl+l to accept line (only in insert mode, no conflict!)
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      filetypes = {
        -- Enabled filetypes (default is enabled for most)
        python = true,
        c = true,
        cpp = true,
        lua = true,
        javascript = true,
        typescript = true,
        -- Disabled filetypes
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    },
    config = function(_, opts)
      require('copilot').setup(opts)

      -- Register Copilot keybinding descriptions with which-key
      -- copilot.lua handles the actual keybindings internally via opts.suggestion.keymap
      local wk_ok, wk = pcall(require, 'which-key')
      if wk_ok then
        wk.add {
          { '<C-g>', desc = 'Copilot: Accept suggestion', mode = 'i' },
          { '<C-f>', desc = 'Copilot: Accept [f]orward word', mode = 'i' },
          { '<C-l>', desc = 'Copilot: Accept [l]ine', mode = 'i' },
          { '<M-]>', desc = 'Copilot: Next suggestion', mode = 'i' },
          { '<M-[>', desc = 'Copilot: Previous suggestion', mode = 'i' },
          { '<C-]>', desc = 'Copilot: Dismiss suggestion', mode = 'i' },
        }
      end
    end,
  },
  -- 'rcarriga/nvim-notify', -- optional
  -- 'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect
}
