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

if [ ! -d /var/run/apache2 ]; then  mkdir -p /var/run/apache2; fi

printf "\n\nAPACHE_RUN_DIR ${APACHE_RUN_DIR}\n\n"

# Move original apache config files to have .orig suffix in filename to preserve them
# Make symlinks of apache config files to files in app/apache
if [ ! -f /etc/apache2/sites-available/000-default.orig.conf ]; then printf "\n/etc/apache2/sites-available/000-default.orig.conf does NOT exists\n";
  printf "\n mv-ing sites-available/000-default.conf to sites-available/000-default.orig.conf\n"
  mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.orig.conf;
fi
if [ ! -L /etc/apache2/sites-available/000-default.conf ]; then printf "\n/etc/apache2/sites-available/000-default.conf is NOT a symlink\n";
  printf "\nmaking a symbolic link of source target:  /var/app/current/app/apache/etc_apache2_sites-available_000-default.conf \n"
  printf "to"
  printf "\nlink name: /etc/apache2/sites-available/000-default.conf\n\n"
  ln -s /var/app/current/app/apache/etc_apache2_sites-available_000-default.conf /etc/apache2/sites-available/000-default.conf;
fi

# setup symlink to xdebug.ini
rm /etc/php/8.1/apache2/conf.d/20-xdebug.ini
ln -s /var/app/current/app/apache/xdebug.ini /etc/php/8.1/apache2/conf.d/20-xdebug.ini


# don't edit apache2.conf and rely on sites-available 000-default.conf for edits
#if [ -f /etc/apache2/apache2.conf ]; then mv /etc/apache2/apache2.conf /etc/apache2/apache2.orig.conf; fi
#ln -s /var/app/current/app/apache/etc_apache2_apache2.conf /etc/apache2/apache2.conf;

chown -R www-data:www-data /var/app/current/app/storage
if [ ! -d /var/app/current/app/storage/framework/cache/data ]; then  mkdir -p /var/app/current/app/storage/framework/cache/data; fi

a2enmod rewrite
printf "\na2enmod rewrite executed\n"

#/usr/sbin/apache2 -k start
#ps aux
#/usr/sbin/apache2 -v
#apache2ctl start
#service apache2 start
#service apache2 status
#tail -f /dev/null
## keeps docker from exiting with code 0
exec apachectl -D FOREGROUND
#apache2ctl -k start
#/etc/init.d/apache2 reload
#exit my bash shell into the container, and just restart the container
# outside of Docker. Because Apache is set as the primary service, this also restarts Apache, and
# doesn't crash the container.
#docker restart laravel
php -v
printf "\n\n"
ifconfig

#printf "\nSTART build directories\n"
#if [ ! -d public/img ]; then  mkdir -p public/img; fi
#if [ ! -d public/imgblog ]; then  mkdir -p public/imgblog; fi
#if [ ! -d public/gallery ]; then  mkdir -p public/gallery; fi
#if [ ! -d public/blog ]; then  mkdir -p public/blog; fi
#if [ ! -d public/video ]; then  mkdir -p public/video; fi
#if [ ! -d contentbackup ]; then  mkdir -p contentbackup; fi
#if [ ! -d contentbackup/staging ]; then  mkdir -p contentbackup/staging; fi
#if [ ! -d contentbackup/live ]; then  mkdir -p contentbackup/live; fi
#printf "\nEND build directories\n"

#npm install
#echo "Running npm audit fix..."
#npm audit fix
#npm run-script startdev


