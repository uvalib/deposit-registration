FROM alpine:3.4

# Add bash cos we dont get by default
RUN apk --update add bash ruby ruby-dev build-base nodejs sqlite-dev zlib-dev libxml2-dev libxslt-dev

# Create the run user and group
RUN addgroup webservice && adduser webservice -G webservice -D

# Specify home 
ENV APP_HOME /deposit-register
WORKDIR $APP_HOME

# Add necessary assets and bundle
RUN gem install bundler io-console --no-ri --no-rdoc
COPY . $APP_HOME
RUN rm $APP_HOME/Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
RUN rake assets:precompile

# Update permissions
RUN chown -R webservice $APP_HOME && chgrp -R webservice $APP_HOME

# Specify the user
USER webservice

# define port and startup script
EXPOSE 3000
CMD /bin/bash -l -c "scripts/entry.sh"
