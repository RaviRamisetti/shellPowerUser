begin=`date +%s`
echo "Baseline of the run started at:"$begin
printf "RAM\tABSOLUTERAM\tCPU\t\n" > /tmp_metrics_$begin.csv
while [ 1 ];
do
CPU_USED=`top -b n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
FREE_MEM=`free -m | grep Mem`
RAMG=`free -h | grep Mem | awk '{print $3}'`
NOW_USED=`echo $FREE_MEM | cut -f3 -d' '`
TOTAL=`echo $FREE_MEM | cut -f2 -d' '`
RAM_PERC=$(echo "scale = 2; $NOW_USED/$TOTAL*100" | bc)
printf "$RAM_PERC\t$RAMG\t$CPU_USED\t\n" >> /tmp_metrics_$begin.csv
test $? -gt 128 && break; done
