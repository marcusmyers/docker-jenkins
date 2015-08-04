FROM jenkins

USER root
RUN apt-get update
RUN apt-get -y install curl php5-cli php5-mcrypt php5-common
RUN echo "gem: --no-rdoc --no-ri" >> /etc/gemrc
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.2
RUN /usr/local/rvm/scripts/rvm use 2.1.2 --defaulti
RUN /usr/local/rvm/scripts/rvm cleanup all
RUN usermod -a -G rvm jenkins
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
RUN mv /usr/bin/composer.phar /usr/bin/composer
RUN apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && rm -rf /var/lib/apt/lists/*
RUN echo ". /usr/local/rvm/scripts/rvm" >> /etc/bash.bashrc

USER jenkins
RUN /usr/local/rvm/scripts/rvm use 2.1.2 --default
ENV GEM_HOME /usr/local/rvm/gems/ruby-2.1.2
ENV GEM_PATH /usr/local/rvm/gems/ruby-2.1.2:/usr/local/rvm/gems/ruby-2.1.2@global
ENV PATH /usr/local/rvm/gems/ruby-2.1.2/bin:/usr/local/rvm/gems/ruby-2.1.2@global/bin:/usr/local/rvm/rubies/ruby-2.1.2/bin:/usr/local/rvm/bin:$PATH
