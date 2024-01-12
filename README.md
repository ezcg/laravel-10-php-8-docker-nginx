On linux (coded on ubuntu) from the command line in laravel/ (and not inside docker) do:

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


