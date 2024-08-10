Start Version notes

The base image for Ubuntu specified in Dockerfile is ubuntu:22.04 because the default repo has all the packages (eg. "php8.1-common") specified in the Dockerfile

Docker Compose version v2.29.1  
docker version 27.1.1  

At the time I wrote this, the command to execute "docker compose" used a hyphen "docker-compose", so I just removed the hyphen in dcUp.sh and dcBuild.sh. For the mysql container, I had to change the MYSQL_USER to "user" as MYSQL_USER "root" is created automatically. Since this is for local development, I left MYSQL_ROOT_PASSWORD: root. There may be a few changes like that needed. 

End Version notes

On linux (coded on ubuntu) from the command line in laravel-directory/ (and not inside docker) do:

If you haven't built the docker container do:
bash dcBuild.sh
bash dcUp.sh

If you've already built the docker container do:
bash dcUp.sh

Find the storage directory and set perms otherwise you'll get a 500 response:
chmod -R o+w storage

Call http://localhost in your browser

If not on linux, copy the commands from the .sh files and run them on the command line.

From memory, but I think this is what I did:
Once it is built, install Laravel by running composer inside the docker container.
docker exec -it laraval bash
composer create-project laravel/laravel laravel

ssh into mysql container:
mysql --host=db -uroot -proot
create a database named laravel
create database laravel

or use artisan to make db and tables:
https://kinsta.com/blog/laravel-crud/

Helpful artisan commands:
php artisan route:list
php artisan route:clear
php artisan config:clear
php artisan cache:clear

restart your application server:
docker restart laravel


