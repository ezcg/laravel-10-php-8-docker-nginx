# commands to set laravel configs, folders and files when running for the first time

# install vendor dir
docker exec -it php composer install

# make .env file from .env.example
docker exec -it php cp .env.example .env
docker exec -it php chown 1000:1000 .env

# gen key for .env
docker exec -it php php artisan key:generate

# create and chmod laravel.log
docker exec -it php touch /var/www/app/storage/logs/laravel.log
docker exec -it php chmod -R 777 /var/www/app/storage

#docker exec -it php apk update
#docker exec -it php apk add vim

docker exec -it php touch ~/.bashrc
docker exec -it php echo "alias ll='ls -ltra'" > ~/.bashrc
docker exec -it php echo "set statusline=%f
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
au BufRead,BufNewFile *.html,*.php,*.phtml,*.inc setfiletype php " > ~/.vimrc


