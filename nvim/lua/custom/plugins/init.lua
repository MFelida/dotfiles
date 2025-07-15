-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'codam-coding-college/codam-header.nvim',
    cmd = { 'Stdheader' },
    opts = {
      default_map = true,
      auto_update = true,
      user = 'mifelida',
      mail = 'mifelida@student.email.com',
    },
    config = function(_, opts)
      require('codamheader').setup(opts)
    end,
  },
}
