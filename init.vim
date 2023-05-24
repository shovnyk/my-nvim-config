" Nik's (Neo)vimrc
" ================

" Plugins
" -------
" install vim-plug: https://github.com/junegunn/vim-plug
" instructions: https://fanwangecon.github.io/Tex4Econ/nontex/install/linux/fn_vim.html#install-vim-plug-plug-ins-manager-for-neovim
call plug#begin('~/.local/share/nvim/site/plugged')
    Plug 'tpope/vim-commentary'                                                 " comment out lines
    Plug 'tpope/vim-repeat'                                                     " repeat complex actions
    Plug 'tpope/vim-surround'                                                   " surround lines with parentheses, quotes, tags
    Plug 'theniceboy/nvim-deus'                                                 " colorscheme with treesitter support
    Plug 'numirias/semshi', {'do' : ':UpdateRemotePlugins', 'for': 'python'}    " python semantic highlighter
    Plug 'nvim-lualine/lualine.nvim'                                            " status line
    Plug 'nvim-lua/plenary.nvim'                                                " dependency for fuzzy finder
    Plug 'nvim-telescope/telescope.nvim'                                        " fuzzy finder
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                 " parsing, highlighting, etc
    Plug 'akinsho/toggleterm.nvim', {'tag': '*'}                                " easy access to terminals
call plug#end()

" Settings
" --------

    " colors
    colorscheme deus

    " nvim-lualine/lualine.nvim: start
    lua require('lualine').setup()

    " akinsho/toggleterm.nvim: start
    lua require('toggleterm').setup()

    " transparent background
    " highlight! Normal ctermbg=None guibg=None
    " highlight! NonText ctermbg=None guibg=None

    " general
    set guicursor=i:block                   " block cursor even in insert mode
    set number                              " enable line numbering
    set modelines=0                         " prevent malicious code being run
    set scrolloff=5                         " cursor at least 5 lines away from bottom
    set wildmode=longest:list,full          " easier to navigate menus, glob completion
    set nowrap linebreak nolist             " (~)softwrap
    set cursorline

    " helps force plugins to load correctly when it is turned back on
    " filetype off
    let g:asmsyntax = 'nasm'

    " searching
    setlocal incsearch  " match as you are typing (only current buffer)
    setlocal hlsearch   " highlight matching results (only current buffer)
    set ignorecase      " case insensitive
    set smartcase       " match uppercase with uppercase
    set wrapscan        " enable wrap around search
    set shortmess-=S    " show number of matches

    " tabs and spaces
    set tabstop=4       " number of VISUAL spaces per TAB when reading
    set softtabstop=4   " number of ACTUAL spaces per TAB when writing
    set shiftwidth=4    " number of spaces to be inserted when pressing >> or <<
    set expandtab       " 1 tab expands to 4 spaces

    " Opening splits
    set splitbelow          " horizontal splits open below
    set splitright          " vertical splits open to the right
    set fillchars+=vert:\│  " separator between splits

" Keybindings
" -----------
    " disable ex mode
    map Q <Nop>

    " leader key = space
    let mapleader = ' ' 

    " disable search highlighting when done
    nnoremap <silent> <leader><Esc> :noh<CR>:match<CR>

    " repeat last change over visually selected region
    vnoremap <silent> . :normal! . <CR>

    " remap * to tab+j (look DOWN)
    nnoremap <tab>j *
    " remap # to tab+k (look UP)
    nnoremap <tab>k #

    " motion for entire buffer
    onoremap <silent> ib :<C-u>normal! mmggVG<CR>
    xnoremap <silent> ib :<C-u>normal! mmggVG<CR>

    " text object for line (doesn't yank newline at end)
    onoremap <silent> il :<C-u>normal! ^v$h<CR>
    xnoremap <silent> il :<C-u>normal! ^v$h<CR>

    " Use ]q [q to jump between quickfix entries
    nnoremap <silent> [q :cprev!<CR>zz
    nnoremap <silent> ]q :cnext!<CR>zz

    " navigate/jump between loaded buffers
    nnoremap <silent> <Tab>l :bnext<CR>
    nnoremap <silent> <Tab>h :bprev<CR>

    " jump to (m)atching parenthesis
    nnoremap <tab>m %
    onoremap <tab>m %

    " toggle spell checking (en_us default)
    nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>

    " open terminal/console
    nnoremap <leader>cj :split \| terminal<CR>
    nnoremap <leader>cl :vertical split \| terminal<CR>
    nnoremap <leader>ck :ToggleTerm direction=float<CR>

    " open special files
    nnoremap <leader>vi :call DynamicOpen("$MYVIMRC")<CR>
    nnoremap <leader>sh :call DynamicOpen("$MYSHELLRC")<CR>

    " copy into system (X11) clipboard (for control+v or shift+insert pasting)
    nnoremap gy "+y
    xnoremap gy "+y
    onoremap gy "+y

    " navigate easily with line wrapping turned on
    if &wrap == 1
        nnoremap <buffer> j gj
        nnoremap <buffer> k gk
    endif

    " use `CTRL+{h,j,k,l}` to navigate windows from any mode: >
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
    inoremap <C-h> <C-\><C-N><C-w>h
    inoremap <C-j> <C-\><C-N><C-w>j
    inoremap <C-k> <C-\><C-N><C-w>k
    inoremap <C-l> <C-\><C-N><C-w>l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " make adjusting split sizes a bit more friendly
    nnoremap <silent> <C-Left> :vertical resize +3<CR>
    nnoremap <silent> <C-Right> : vertical resize -3<CR>
    nnoremap <silent> <C-Up> :resize +3<CR>
    nnoremap <silent> <C-Down> :resize -3<CR>
    nnoremap <silent> <C-=> <C-w>=

    " compile (run makeprg via :make)
    nnoremap <leader>ma :make<CR>

    " working with binary files (using xxd)
    " hex read (hr)
    nnoremap <leader>hr :%!xxd<CR> :set filetype=xxd<CR>
    " hex write (hw)
    nnoremap <leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

    " Find files using Telescope
    nnoremap <leader>ff <cmd>Telescope find_files<CR>
    nnoremap <leader>fr <cmd>Telescope oldfiles<CR>

" Commands
" --------
    " typing :W instead of :w is annoying
    command Write :w!

    " view pdf and html files in their appropriate viewers
    command See :!mysee %

    " close all buffers except the current one
    " command Only :%bdelete <bar> edit #<bar>normal `"

" Autocommands
" ------------
    " force recognize syntax for certain files that are not recognized
    augroup ForceFileTypes
        au!
        au BufRead              vifmrc              :setlocal filetype=vim
        au BufNewFile,BufRead   README.txt,README   :setlocal filetype=markdown
        au BufNewFile,BufRead *.todo                :setlocal filetype=markdown
        au BufNewFile,BufRead *.help                :setlocal filetype=help
        au BufNewFile,BufRead *.ckt,*.cir           :setlocal filetype=spice
        au BufNewFile,BufRead *.asm                 :setlocal filetype=nasm
        au BufNewFile,BufRead *.tex                 :setlocal filetype=tex
        au BufNewFile,BufRead *.yab                 :setlocal filetype=basic
    augroup END

    augroup TreeSitterHighlighting
        au!
        au FileType cpp,c,java :TSEnable highlight
    augroup END

    " startup routine
    augroup VimStartup
        au!
        " jump to last cursor position on opening (pick up where you left off)
        au BufReadPost *
                    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                    \   exe "normal g'\"" |
                    \ endif
        " center text upon opening file
        au BufRead * norm zz
        " disable automatic commenting
        au FileType * set formatoptions-=cro
    augroup END

    " vim commentary: change default comments triggered by binding 'gcc'
    augroup ChangeCommentStyle
        au!
        au FileType markdown,beamer :setlocal commentstring=<!--\ %s\ --> 
        au FileType gnuplot         :setlocal commentstring=#\ %s
        au FileType matlab          :setlocal commentstring=%\ %s
        au FileType vhdl            :setlocal commentstring=--\ %s
        au FileType cpp             :setlocal commentstring=//\ %s
        au FileType nasm            :setlocal commentstring=;\ %s
    augroup END

    " invoke appropriate compiler
    augroup Compilers
        au!
        au FileType c           :setlocal makeprg=tcc\ -run\ %
        au FileType markdown    :setlocal makeprg=pandoc\ \ 
                    \--metadata-file=$HOME/.pandoc/metadata.yaml\ \ 
                    \--defaults=$HOME/.pandoc/defaults.yaml\ -o\ %:r.pdf\ %
        au FileType python      :setlocal makeprg=python3\ %
        au FileType cpp         :setlocal makeprg=g++\ %
        au FileType nasm        :setlocal makeprg=make\ file=%:t:r\ run_and_clean
        au FileType java        :setlocal makeprg=javac\ %\ &&\ java\ %:t:r\ &&\ rm\ %:t:r.class
        au FileTYpe sh,bash     :setlocal makeprg=bash\ %
        au FileType basic       :setlocal makeprg=yabasic\ %
    augroup END

    " invoke appropriate debugger
    augroup Debuggers
        au! FileType python nnoremap <leader>db 
    augroup END

" Functions
" ---------
    " open files depending on the width of window in vertical/horizontal split
    let g:dynamic_open_width_threshold = 100
    function! DynamicOpen(filepath)
        if line('$') == 1 && &modified == 0
            execute "edit " . a:filepath
        elseif winwidth(1) > g:dynamic_open_width_threshold
            execute "vnew " . a:filepath
        else
            execute "new " . a:filepath
        endif
        return 0
    endfunction

" External programs
" -----------------
    " searching for keywords in files in current directory
    set grepprg=ag\ --vimgrep\ $*           " ag instead of grep
    set grepformat=%f:%l:%c:%m              " output format for ag (gcc like)

    " formating text in buffer with 'gq' operator
    set formatprg=par\ jw72                 " operator = gq
