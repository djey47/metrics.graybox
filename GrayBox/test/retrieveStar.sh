#! /bin/sh
#Test muti retrieve functionality
curl -X GET -d "" http://localhost:4568/server/APP_TEST
#404
curl -X GET -d "" http://localhost:4568/server/FOO