#! /bin/bash
#MSYSGIT (Windows) can't run this script!
#Test basic store feature (loop over 1k items with 60hz rate)
echo Will publish @APP_TEST/STORE/LOOP @60Hz !

start=`date +%s%N`
start="$(( 10#$start ))"
for i in {1..1000}
  	do
  		e=$(date +%s.%N)
		curl -X POST -d "" http://localhost:4567/collector/APP_TEST/STORE/LOOP/$i-$e
		#Must take curl response time into account
		sleep 0.007
	done
finish=`date +%s%N`
finish="$(( 10#$finish ))"
diff=$(($finish-$start))

printf "=============\n"
printf "Done in $(($diff/1000000)) ms"
printf "\n"
avg=$(($diff/1000/1000000))
printf "Average: $avg ms/req <-> $((1000/$avg)) req/s (Hz)"
printf "\n"