#if [ -z "$DOCKER_HOST" ]; then
#   echo "ERROR: no DOCKER_HOST defined"
#   exit 1
#fi

if [ -z "$DOCKER_HOST" ]; then
   DOCKER_TOOL=docker
else
   DOCKER_TOOL=docker-legacy
fi

# set the definitions
INSTANCE=deposit-registration
NAMESPACE=uvadave

# environment attributes
API_TOKEN=94DE1D63-72F1-44A1-BC7D-F12FC951
DEPOSITAUTH_URL=tp://docker1.lib.virginia.edu:8230
DEPOSITREG_URL=http://docker1.lib.virginia.edu:8220
USERINFO_URL=http://docker1.lib.virginia.edu:8010

DOCKER_ENV="-e API_TOKEN=$API_TOKEN -e DEPOSITAUTH_URL=$DEPOSITAUTH_URL -e DEPOSITREG_URL=$DEPOSITREG_URL -e USERINFO_URL=$USERINFO_URL"

# stop the running instance
$DOCKER_TOOL stop $INSTANCE

# remove the instance
$DOCKER_TOOL rm $INSTANCE

# remove the previously tagged version
$DOCKER_TOOL rmi $NAMESPACE/$INSTANCE:current  

# tag the latest as the current
$DOCKER_TOOL tag -f $NAMESPACE/$INSTANCE:latest $NAMESPACE/$INSTANCE:current

$DOCKER_TOOL run -d -p 8221:3000 $DOCKER_ENV --name $INSTANCE $NAMESPACE/$INSTANCE:latest

# return status
exit $?
