FROM ubuntu:22.04 as base

# Set the working directory
#WORKDIR /app
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ARG DEBIAN_FRONTEND=noninteractive

# Install the necessary dependencies
RUN apt-get -y update && apt-get install -y \
    apache2 \
    php8.1 \
    php8.1-fpm \
    php-mysql \
    libapache2-mod-php8.1 \
    vim \
    net-tools \
    curl \
    gnupg \
    wget \
    telnetd \
    build-essential \
    lsof \
    mysql-client \
    python-is-python3 \
    cron \
    openssh-client \
    composer \
    sudo \
    php-xdebug \
    php8.1-xml \
    php8.1-curl \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    php8.1-cli \
    php8.1-common \
    php8.1-imap \
    php8.1-redis \
    php8.1-zip \
    php8.1-mbstring

# apt install php8.1-common php8.1-mysql php8.1-cgi php8.1-mbstring php8.1-curl php8.1-gd php8.1-xml php8.1-xmlrpc php-pear php8.1-fpm

#RUN mkdir /var/run/apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV APACHE_RUN_DIR /var/run/apache2
RUN echo "1 APACHE_RUN_DIR "
RUN echo ${APACHE_RUN_DIR}

#RUN source /etc/apache2/envvars

# set locale
#RUN locale-gen "en_US.UTF-8"
#RUN echo LC_ALL="en_US.UTF-8" >> /etc/default/locale
#RUN echo LC_CTYPE="en_US.UTF-8" >> /etc/default/locale
#RUN echo LANG="en_US.UTF-8" >> /etc/default/locale
#RUN echo LC_ALL="en_US.UTF-8" >> /etc/environment
#RUN echo LC_CTYPE="en_US.UTF-8" >> /etc/environment
#RUN echo LANG="en_US.UTF-8" >> /etc/environment
#ENV LC_CTYPE="en_US.UTF-8"
#ENV LC_ALL="en_US.UTF-8"
#ENV LANG="en_US.UTF-8"

# timezone setup
RUN echo TZ=America/Los_Angeles >> /etc/environment
RUN rm -f /etc/localtime && ln -nsf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# get rid of notice:
# AH00558: apache2: Could not reliably determine the server's fully qualified domain name,
# using 127.0.0.1. Set the 'ServerName' directive globally
RUN grep -qF -- "ServerName localhost" "/etc/apache2/apache2.conf" || echo "ServerName localhost" >> "/etc/apache2/apache2.conf"


# Copy the application code into the container
#COPY . .

# Expose port 80
#EXPOSE 80

# Start the Apache2 server
#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
