#!/bin/bash

cpuload() {
dd if=/dev/zero iflag=fullblock bs=500MiB count=2|nice -n $1 bzip2 -9 > /dev/null;

}

cpucount=$(grep processor /proc/cpuinfo | wc -l)
echo "++++++++++++++++++++++++++++++++++++++++"
echo "CPU count - "$cpucount
echo "Enter NICEs for created processes, on one line, separated by spaces"
echo "Example: -20 -10 0 10 20"
echo "Quantity more than CPU count"
read -e -p "NICEs : " pris

#pris="20 20 10 0 -10 -10 -20 -20";
i=-1;
for pri in $pris
	do
		((i++));
		#pstart[$i]=`date +%s`;
		cpuload $pri&pid=$!;
		pids[$i]=$pid;
		pnices[$pid]=$pri;
		pstart[$pid]=`date +%s`;
		PID_LIST+=" $pid";
#		ce -n $priecho `date +%s`
#		echo $pri"  "${pids[$i]}"  "${pstart[$i]};
	done

trap "kill $PID_LIST" SIGINT;
sleep 0.1;
echo "Parallel processes have started";

pidchs=$PID_LIST
pcount=$i;

while [ $pcount -ge 0 ]
do	
	for pidch in $pidchs 
		do
			if [[ ! -d /proc/$pidch ]] 
			then 
				#echo $pidch
				echo "PID "$pidch" with " ${pnices[$pidch]}" is finish";
				pidchs=( ${pidchs[@]/$pidch} )
				((pcount--))
				pstop[$pidch]=`date +%s`;
				#echo $pcount
			fi
		done
done		
wait $PID_LIST;
echo
echo "All processes have completed";

for (( a=0; a <= $i; a++ ))
do
	echo "PID "${pids[$a]}" NICE "${pnices[${pids[$a]}]}" TIME "$((${pstop[${pids[$a]}]} - ${pstart[${pids[$a]}]}));
done
