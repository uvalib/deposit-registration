export GOPATH=$(pwd)

res=0
if [ $res -eq 0 ]; then
  env GOOS=darwin go build -o bin/deposit-reg.darwin
  res=$?
fi

if [ $res -eq 0 ]; then
  env GOOS=linux go build -o bin/deposit-reg.linux
  res=$?
fi

exit $res
