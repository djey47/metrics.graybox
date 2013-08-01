#! /bin/sh
#Test basic retrieve functionality
curl -X GET -d "" http://localhost:4568/server/APP_TEST/CTX1/NAT1
#404
curl -X GET -d "" http://localhost:4568/server/FOO/FOO/FOO	