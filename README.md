>>>Start Version notes

The base image for Ubuntu specified in Dockerfile is ubuntu:22.04 because the default repo has all the packages (eg. "php8.1-common") specified in the Dockerfile

Docker Compose version v2.29.1  
docker version 27.1.1  

At the time I wrote this, the command to execute "docker compose" used a hyphen "docker-compose", so I just removed the hyphen in dcUp.sh and dcBuild.sh. For the mysql container, I had to change the MYSQL_USER to "user" as MYSQL_USER "root" is created automatically. Since this is for local development, I left MYSQL_ROOT_PASSWORD: root. There may be a few changes like that needed. 

You may have to run the bash commands as sudo, eg.sudo bashBuild.sh

If your OS doesn't work with .sh files (Apple doesn't if I recall correctly), then just copy the commands in the .sh file and paste them onto the command line. You may have to preface them with sudo.

<<<End Version notes


If you haven't built the docker container do, on linux (coded on ubuntu) from the command line in laravel-directory/ (and not inside docker):
bash dcBuild.sh
bash dcUp.sh

If you've already built the docker container (you have already run bash dcBuild.sh) do:
bash dcUp.sh

Find the storage directory and set perms otherwise you'll get a 500 response:
chmod -R o+w storage

To change ports that apache,debug or mysql listen on, edit /.docker_env

Call http://localhost in your browser with any port changes added to the url.

If not on linux, copy the commands from the .sh files and run them on the command line.

[//]: # (Enter docker container:)

[//]: # (docker exec -it laraval bash)

[//]: # (Execute command inside container:)

[//]: # (composer create-project laravel/laravel laravel)

docker exec -it db bash mysql_docker_init.sh


[//]: # (ssh into mysql container:)

[//]: # (mysql --host=db -uroot -proot)

[//]: # (create database laravel)

or use artisan to make db and tables:
https://kinsta.com/blog/laravel-crud/

Helpful artisan commands:
php artisan route:list
php artisan route:clear
php artisan config:clear
php artisan cache:clear

In /app directory, inside docker container, run on the command line:
composer install

restart your application server:
docker restart laravel

Call localhost:8001 in your browser and click on Run migrations 

bugs and fixes, notes see notes.txt



