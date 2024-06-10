# remove stale pid files
rm -f $APP_HOME/tmp/pids/server.pid > /dev/null 2>&1

# run the server
/usr/local/bundle/bin/rails server -b 0.0.0.0 -p 8080
