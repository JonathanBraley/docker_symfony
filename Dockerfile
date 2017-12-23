FROM nginx:1.13.7
MAINTAINER night-gold

#We add the basic of the container to begin with
RUN apt-get update && apt-get install -y curl apt-transport-https lsb-release ca-certificates wget

#With this installed we are going to install php in version 7.1 wich is needed for symfony 4.0.

#First we are going to add the php7.1 repo to the image and update aptitude
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && apt-get update

#We can now install php in 7.1 version and composer.
RUN apt-get install -y php7.1-cli php7.1-cgi php7.1-common php7.1-fpm php7.1-mysql php7.1-curl php7.1-json php7.1-gd php7.1-mcrypt php7.1-msgpack php7.1-memcached php7.1-intl php7.1-gmp php7.1-geoip php7.1-mbstring php7.1-xml php7.1-zip

#We can now install composer without worry.
RUN apt-get install -y composer

#As php is installed with fpm we will upload our new config file in place of the old one
COPY assets/default.conf /etc/nginx/conf.d/

#Now we will install the others product that are needed to run a full symfony project (node and yarn)

