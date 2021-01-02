set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/root/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"mappings
map <C-n> :NERDTree<CR>


" Настройки табов для Python, согласно рекоммендациям
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=4 "4 пробела в табе
" Автоотступ
set autoindent
" Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
" Включаем 256 цветов в терминале, мы ведь работаем из иксов?
" Нужно во многих терминалах, например в gnome-terminal
set t_Co=256

" Перед сохранением вырезаем пробелы на концах (только в .py файлах)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" В .py файлах включаем умные отступы после ключевых слов
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

syntax on "Включить подсветку синтаксиса

set number "Включаем нумерацию строк
set mousehide "Спрятать курсор мыши когда набираем текст
" set mouse=a "Включить поддержку мыши
set termencoding=utf-8 "Кодировка терминала
" set novisualbell "Не мигать
set t_vb= "Не пищать! (Опции 'не портить текст', к сожалению, нету)
" Удобное поведение backspace
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Вырубаем черточки на табах
set showtabline=1

" Переносим на другую строчку, разрываем строки
set wrap
set linebreak

" Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set encoding=utf-8 " Кодировка файлов по умолчанию
set fileencodings=utf8,cp1251

set clipboard=unnamed
" set ruler


" Выключаем звук в Vim
set visualbell t_vb=


" https://vimawesome.com/
" https://github.com/junegunn/vim-plug
" https://github.com/VundleVim/Vundle.vim
" https://www.youtube.com/watch?v=65Wq4fjREUU&list=PLhoH5vyxr6QqPtKMp03pcJd_Vg8FZ0rtg
" https://www.youtube.com/watch?v=zNnsNtBF80g&list=PLcjongJGYetkY4RFSVftH43F91vgzqB7U&index=1
" https://github.com/ycm-core/YouCompleteMe
" https://gist.github.com/alexey-goloburdin/62d5b1b5ec19275d33497b7f3c0b6eec
" https://www.youtube.com/watch?v=8qfc7Nqd5hw