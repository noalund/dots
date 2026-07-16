set nocompatible
filetype plugin on
syntax on

set number
set relativenumber

autocmd FileType vimwiki nnoremap <buffer> <leader>x :call ToggleTodo()<CR>

function! ToggleTodo()
  let l:line = getline('.')
  if l:line =~ '\[ \]'
    call setline('.', substitute(l:line, '\[ \]', '[x]', ''))
  elseif l:line =~ '\[x\]'
    call setline('.', substitute(l:line, '\[x\]', '[ ]', ''))
  endif
endfunction

nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>ct :tabclose<CR>
nnoremap <leader>hh :noh<CR>
nnoremap <C-n> n
nnoremap <C-p> N

" apply numbered prefix conventions to selected lines:
" simple 1-,2-,3-,etc. for album track ordering
" ...
" increment on line immediately before selection for photos
" e.g., ["2001 - test.jpg", "test.mp4", "test.png"] -->
" ["2001 - test.jpg", "2002 - test.mp4", "2003 - test.png", etc.]
" assumes "test.mp4" is first *selected* line
function! NumberSelected()
  let choice = input('Convention? [1=music, 2=images]: ')

  if choice ==# '1'
    execute "'<,'>s/^/\\=line('.')-line(\"'<\")+1 . '-'/"
  elseif choice ==# '2'
    let n = str2nr(matchstr(getline(line("'<") - 1), '^\d\+')) + 1
    for lnum in range(line("'<"), line("'>"))
      call setline(lnum, n . ' - ' . getline(lnum))
      let n += 1
    endfor
  endif
endfunction

xnoremap <leader>tn <Esc>:call NumberSelected()<CR>

" \gg bindings for groff & lilypond
augroup compile_to_pdf
  autocmd!
  autocmd FileType nroff nnoremap <buffer> <leader>gg :update<CR>:silent !groff -ms -Tpdf % > %:r.pdf<CR>
  autocmd FileType lilypond nnoremap <buffer> <leader>gg :update<CR>:silent !lilypond --pdf %:r<CR>
augroup END

" spelling
nnoremap <leader>ss :set spell!<CR>
nnoremap <leader>sf ]s
nnoremap <leader>sd [s
nnoremap <A-Space> z=
command! -nargs=? AddWord execute 'spellgood ' . (empty(<q-args>) ? expand('<cword>') : <q-args>)
command! -nargs=? RemoveWord execute 'spellwrong ' . (empty(<q-args>) ? expand('<cword>') : <q-args>)

" 4 spaces for tabs in HTML/CSS/JS/Bash/Python/JSON
autocmd FileType html,css,javascript,sh,python,jsonc setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" 2 spaces for Vim Script
autocmd FileType vim setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-tree/nvim-tree.lua'
Plug 'vimwiki/vimwiki'
Plug 'nvim-lualine/lualine.nvim'
Plug 'dylanaraps/wal.vim'
Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }
Plug 'rafamadriz/friendly-snippets'

call plug#end()

" pywal16

set notermguicolors
colorscheme wal

" nvim-tree
lua require("nvim-tree").setup()

nnoremap <leader>ff :NvimTreeToggle<CR>

"lua-line
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END

"blink.cmp
lua << EOF
require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono'
  },
  completion = {
    documentation = { auto_show = false }
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
})
EOF
