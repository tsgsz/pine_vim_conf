
"通用选项
"---------------------------------------------
"colorscheme descert "色彩方案

syntax on                  "语法高亮
filetype plugin on         "启用特殊文件插件
filetype indent on         "启用特殊文件缩进

set nocompatible  "不兼容vi模式
set showmatch     "括号匹配
set ruler         "在角落显示行号和列号
set hlsearch      "匹配结果高亮显示
set incsearch     "实时高亮匹配结果
set number        "显示行号
"set wrap          "显示时自动换行
set nowrap          "显示时自动换行
set autoindent    "自动缩进
set expandtab     "使用空格代替\t
set backup        "启用备份
set wildmenu      "使用命令行时可用<Tab>补全

set colorcolumn=80     "在80个字符处显示一个红条
set tabstop=4          "设置4个空格代替1个\t

set scrolloff=3        "至少离底部3行
set shiftwidth=4       "自动缩进时每次的格数

set backupdir=~/.vim_backup "设置备份目录

set encoding=utf-8     "utf-8编码
set termencoding=utf-8 "终端utf-8编码
set fileencoding=utf-8 "默认的文件编码utf-8
set fileencodings=utf-8,gb18030,gbk,utf-16,big5


"C 语言选项
"-------------------------------------------------
set cindent            "设置C风格的缩进

"键值映射
"-------------------------------------------------

"设置leader key
let mapleader=','
let g:C_MapLeader=','

"窗口间的切换
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <c-l> <C-W>l

"插件设置
"------------------------------------------------------
"ctag 设置
"自动更新tags文件
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"cscope 设置
"打开文件时自动加载cscope.out
if has("cscope")
    set nocscopeverbose
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set cscopeverbose
endif
"cscope按键映射
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>si :cs find i <C-R>=expand("%:t")<CR><CR>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>

"plugin: tagbar.vim
nmap <silent> <F3>      :TagbarToggle <CR>
imap <silent> <F3>      <C-O>:TagbarToggle <CR>

"plugin: project.vim
nmap <F8>      :Project<CR>
imap <F8>      <Esc>:Project<CR>

"plugin: a.vim
nmap <F6>      :update<CR>:A<CR>
imap <F6>      <Esc>:update<CR>:A<CR>

"plugin: minibufexpl.vim
nmap <leader>,  :bn<CR>
nmap <leader>.  :bp<CR>

"plugin: code_complete.vim

"plugin: NERD_tree.vim
nmap <silent> <F2>      :NERDTreeToggle<CR>
imap <silent> <F2>      <C-O>:NERDTreeToggle<CR>
let NERDTreeIgnore=['tags', '\.swp$', '\.o', '\.log', '\~$']

"plugin: NERD_commenter
let NERDSpaceDelims = 1

"plugin: DoxygenToolkit.vim
let g:license_tag="KLND Inc. All Rights Reserved."
let g:author_name="Pine <cdtsgsz@gmail.com>"

"plugin: lookupfile.vim 
let g:LookupFile_TagExpr = '"./tags"'
nmap <silent> <leader>lt :LUTags<CR>
nmap <silent> <leader>lb :LUBufs<CR>
nmap <silent> <leader>lw :LUWalk<CR>

"plugin: omnicppcomplete
set completeopt=menu

"函数
"-----------------------------------------------------
"C++  文件头
function! <SID>GenCppFileHeader()
	let l:year = strftime("%Y")
	exec "normal O"."// Copyright ".l:year.", ".g:license_tag
	exec "normal o"."Author: ".g:author_name
	startinsert!
endfunction

"python 文件头
function! <SID>GenPythonFileHeader()
	let l:year = strftime("%Y")
	exec "normal O"."#!/bin/env python\n# -*- coding: utf-8 -*-\n# Copyright ".l:year.", ".g:license_tag
	exec "normal o"."# Author: ".g:author_name
	startinsert!
endfunction

"自动命令
"--------------------------------------------------------
"自动生成文件头
if has("autocmd")
    au BufNewFile * if (&filetype=='cpp' || &filetype=='c') |
        \ call <SID>GenCppFileHeader() | endif
    au BufNewFile * if (&filetype=='python') |
        \ call <SID>GenPythonFileHeader() | endif

    au FileType python set et |setlocal shiftwidth=2| setlocal softtabstop=2| setlocal ts=2
endif

"记住上次光标位置
if has('autocmd') 
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"自动识别语言
augroup filetype
    autocmd! BufRead,BufNewFile *.proto setfiletype proto
augroup end
