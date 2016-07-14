if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

# set the definitions
INSTANCE=deposit-registration
NAMESPACE=uvadave

# environment attributes
API_TOKEN=94DE1D63-72F1-44A1-BC7D-F12FC951
DEPOSITREG_URL=http://docker1.lib.virginia.edu:8220
USERINFO_URL=http://docker1.lib.virginia.edu:8010

DOCKER_ENV="-e API_TOKEN=$API_TOKEN -e DEPOSITREG_URL=$DEPOSITREG_URL -e USERINFO_URL=$USERINFO_URL"

docker run -t -i -p 8221:3000 $DOCKER_ENV $NAMESPACE/$INSTANCE /bin/bash -l
