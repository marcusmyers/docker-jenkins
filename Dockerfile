FROM jenkins

USER root
RUN apt-get update
RUN apt-get -y install curl php5-cli php5-mcrypt php5-common
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer
