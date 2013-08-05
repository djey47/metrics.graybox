#! /bin/bash
#Test basic store feature (loop over 1k items)
echo Will publish @APP_TEST/STORE/LOOP !
for i in {1..1000}
  	do
		curl -X POST -d "" http://localhost:4567/collector/APP_TEST/STORE/LOOP/$i
	done
echo done.