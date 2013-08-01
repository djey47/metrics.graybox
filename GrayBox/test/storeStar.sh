#! /bin/sh
#Test muti store feature
curl -X POST -H "Content-Type: application/json" -d @data/dataCollection.json http://localhost:4567/collector/APP_TEST