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
  -- 'rcarriga/nvim-notify', -- optional
  -- 'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect
}
