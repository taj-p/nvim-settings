call plug#begin(stdpath('data') . '/plugged')
  " File explorer
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'


  " CoC & TypeScript plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint']
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'

  " Git plugins
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " Automatically detecting tab spacing
  Plug 'tpope/vim-sleuth'
  Plug 'editorconfig/editorconfig-vim'

  " Commenting
  Plug 'preservim/nerdcommenter'
  " Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Color themes
  Plug 'dracula/vim'
  Plug 'rafi/awesome-vim-colorschemes'

  " Vim movement plugins
  Plug 'justinmk/vim-sneak'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  " Golang
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " Terraform
  Plug 'hashivim/vim-terraform'

  " Navigation
  Plug 'folke/zen-mode.nvim'

  " Search plugins
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()

" let g:available_colorschemes = ['256noir', 'abstract', 'afterglow', 'alduin', 'anderson', 'angr', 'ayu-vim', 'Apprentice', 'Archery', 'Atom', 'carbonized', 'challenger-deep', 'deep-space', 'deus', 'dogrun', 'flattened', 'focuspoint', 'fogbell', 'github', 'gotham', 'gruvbox', 'happy hacking', 'Iceberg', 'papercolor', 'parsec', 'scheakur', 'hybrid', 'hybrid-material', 'jellybeans', 'lightning', 'lucid', 'lucius', 'materialbox', 'meta5', 'minimalist', 'molokai', 'molokayo', 'mountaineer', 'nord', 'oceanicnext', 'oceanic-material', 'one', 'onedark', 'onehalf', 'orbital', 'paramount', 'pink-moon', 'purify', 'pyte', 'rakr', 'rdark-terminal2', 'seoul256', 'sierra', 'solarized8', 'sonokai', 'space-vim-dark', 'spacecamp', 'sunbather', 'tender', 'termschool', 'twilight256', 'two-firewatch', 'wombat256', 'dracula' ]
colorscheme jellybeans

" My favourite colorschemes: OceanicNext, Nord, sierra, dogrun, yellow-moon, jellybeans

function RCS() " For RandomColorScheme
  let mycolors = split(globpath(&rtp,"**/colors/*.vim"),"\n") 
  exe 'so ' . mycolors[localtime() % len(mycolors)]
  unlet mycolors
endfunction

" call RCS() " For RandomColorScheme

function! ShowColourSchemeName()
    try
        echo g:colors_name
    catch /^Vim:E121/
        echo "default"
    endtry
endfunction

:command NewColor call RandomColorScheme()

let g:sneak#label = 1

" Navigation

"Config Section

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let mapleader = " "

"Color themes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

"Nerd Tree
let NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeWinSize=60
let g:NERDTreeQuitOnOpen=1
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeFind<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
" au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Use silver searcher for FZF searcher
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" If you press ctrl + j and there is a pane below your pane, switch to it.
" Otherwhise create a new split pane below and switch to it.
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" Open FZF files to tab, horizontal, or vertical split
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Remap keys to jump to next/prev error
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Relative line numbering
set relativenumber
set rnu

" Tab to move through code completion options
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" Enter to select some option
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>z  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>x  <Plug>(coc-fix-current)

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"example defaults for new projects
set expandtab
set tabstop=2
set shiftwidth=2

" Golang
autocmd FileType go nnoremap <buffer> gr :GoReferrers<CR>

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 0
let g:go_highlight_structs = 0
let g:go_highlight_types = 1

" let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_doc_popup_window = 1

au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)

au FileType go nmap <leader>t :GoTest -short<cr>
au FileType go nmap <leader>tc :GoCoverageToggle -short<cr>

" Navigation

lua << EOF
  require("zen-mode").setup {
    window = {
      backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      -- height and width can be:
      -- * an absolute number of cells when > 1
      -- * a percentage of the width / height of the editor when <= 1
      -- * a function that returns the width or the height
      width = 120, -- width of the Zen window
      height = 1, -- height of the Zen window
      -- by default, no options are changed for the Zen window
      -- uncomment any of the options below, or add other vim.wo options you want to apply
      options = {
        -- signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
      },
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false }, -- disables the tmux statusline
      -- this will change the font size on kitty when in zen mode
      -- to make this work, you need to set the following kitty options:
      -- - allow_remote_control socket-only
      -- - listen_on unix:/tmp/kitty
      kitty = {
        enabled = false,
        font = "+4", -- font size increment
      },
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win)
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
    end,
    }
EOF

nnoremap zm :ZenMode <CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Svelte
let g:vim_svelte_plugin_use_typescript = 1
