if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

# set the definitions
INSTANCE=deposit-reg
NAMESPACE=uvadave

# build the image
docker build -t $NAMESPACE/$INSTANCE .

# return status
exit $?
