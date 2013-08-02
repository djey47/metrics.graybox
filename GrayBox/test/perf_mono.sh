#! /bin/bash
#Mono retrieve feature -> performance test
#Computes delays between post and get requests and total execution time 

start=`date +%s%N`
start="$(( 10#$start ))"
#printf "\nStart:$start\n"
for i in {1..100}
  do
		startit=`date +%s%N`
		startit="$(( 10#$startit ))"
		
		# Store
		curl -X POST -d "" http://localhost:4567/collector/APP_TEST/PERF_MONO/$i/$startit
 
		# Retrieve
		curl -X GET -d "" http://localhost:4568/server/APP_TEST/PERF_MONO/$i
		
		# TODO check HTTP STATUS = 200
						
		finishit=`date +%s%N`
		finishit="$(( 10#$finishit ))"
		diffit=$(($finishit-$startit))		
		
		printf "\nR/W result: $(($diffit/1000000)) ms\n" 
done

finish=`date +%s%N`
finish="$(( 10#$finish ))"
#printf "\nFinish:$finish"
diff=$(($finish-$start))

printf "\n=============\n"
printf "Done in $(($diff/1000000)) ms"
printf "\n"
printf "Average: $(($diff/100/1000000)) ms/req"
printf "\n"