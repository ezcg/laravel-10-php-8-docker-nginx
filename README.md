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

Enter docker container:
docker exec -it laraval bash
Execute command inside container:
composer create-project laravel/laravel laravel

ssh into mysql container:
mysql --host=db -uroot -proot
create database laravel

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

===

Bugs/Fixes

I had to delete dbdata in laravel-10-php-8-docker. Apparently I tried to build with a different version of mysql and 
files of that version where left behind. Deleting dbdata and redoing dcBuild.sh created the following error.

ERROR 1449 (HY000): The user specified as a definer ('mysql.infoschema'@'localhost') does not exist
Fixed by doing this: 
https://stackoverflow.com/a/62129259/779803

SQLSTATE[HY000] [1130] Host '172.27.0.3' is not allowed to connect to this MySQL server
host: localhost
select host from mysql.user where user='root'\G

CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;

Comment out the bind address from the file /etc/mysql/my.cnf:
#bind-address  = 127.0.0.1
sudo service mysql restart

Tried to add myself to the same group as Docker and it didn't work. Notes:

If you want to add your user to the group that docker is part of, for Ubuntu list id:group of docker:

stat -c '%u:%g' /var/run/docker.sock

For me, this displayed:

0:0

View groups current user is a member of:

id --groups

add user to group docker is in:

sudo usermod -a -G [group-name] [user-name]

For me, this was sudo usermod -a -G 0 matt

You may need to logout and login (close and reopen the terminal) or restart to get the groups permissions.


