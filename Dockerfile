FROM centos:7

RUN yum -y update && yum -y install which tar epel-release && yum -y install nodejs

# install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | /bin/bash -s stable

# install ruby
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3.0"
RUN /bin/bash -l -c "rvm use 2.3.0 --default"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# define port and startup script
EXPOSE 3000
CMD /bin/bash -l -c "scripts/entry.sh"

# create work directory
ENV APP_HOME /deposit-register
RUN mkdir $APP_HOME

ADD . $APP_HOME
WORKDIR $APP_HOME

RUN /bin/bash -l -c "bundle install"
