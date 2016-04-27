FROM centos:7

RUN yum -y update && yum -y install which tar epel-release && yum -y install nodejs

# install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | /bin/bash -s stable

# install ruby
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3.0"
RUN /bin/bash -l -c "rvm use 2.3.0 --default"

# Create the run user and group
RUN groupadd -r webservice && useradd -r -g webservice webservice

# Specify home 
ENV APP_HOME /deposit-register
WORKDIR $APP_HOME

# Create directories and update permissions
#RUN chown -R webservice $APP_HOME && chgrp -R webservice $APP_HOME
#RUN mkdir /home/webservice
#RUN chown -R webservice /home/webservice && chgrp -R webservice /home/webservice
#RUN chown -R webservice /usr/local/rvm/gems/ruby-2.3.0 && chgrp -R webservice /usr/local/rvm/gems/ruby-2.3.0

# Specify the user
#USER webservice

# define port and startup script
#EXPOSE 3000
#CMD /bin/bash -l -c "scripts/entry.sh"

# Add necessary assets and bundle
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
COPY . $APP_HOME
RUN /bin/bash -l -c "bundle install"

RUN chown -R webservice $APP_HOME && chgrp -R webservice $APP_HOME
USER webservice
EXPOSE 3000
CMD /bin/bash -l -c "scripts/entry.sh"
