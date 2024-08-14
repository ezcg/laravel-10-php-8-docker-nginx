#!/bin/bash

#For Windows, remove trailing \r character by running on the cmd line:
#sed -i 's/\r$//' docker_init.sh

printf "\n\n===============================\ndocker_init.sh\n\n"

touch ~/.bashrc
echo "alias ll='ls -ltra'" > ~/.bashrc
echo "set statusline=%f
set pastetoggle=<F2>
set smartcase
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent
hi apacheComment guifg=white
set syntax=php
au BufRead,BufNewFile *.html,*.php,*.phtml,*.inc setfiletype php " > /root/.vimrc

bash apk update
bash apk add vim

