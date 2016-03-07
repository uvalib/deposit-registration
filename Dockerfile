FROM centos:7

ENV APP_HOME /deposit-reg
RUN mkdir -p $APP_HOME/scripts $APP_HOME/bin $APP_HOME/public

EXPOSE 8080
CMD scripts/entry.sh
WORKDIR $APP_HOME

COPY scripts/entry.sh $APP_HOME/scripts/entry.sh
COPY bin/deposit-reg.linux $APP_HOME/bin/deposit-reg
COPY public/ $APP_HOME/public/
