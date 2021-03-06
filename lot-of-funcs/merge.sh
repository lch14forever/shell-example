for file in $@
do 
    counter=0

    seq 18 30 | awk '{print $file"\t"$file}' > mask.tmp

    for gene in $(< RClist.txt)
    do
	((counter+=1))
	grep $gene $file | cut -f2,4  > $counter.tmp
	join -a 1 -e 0 -o '0,1.2,2.2' mask.tmp $counter.tmp | awk -v var=$gene -v file=$file '{print var"\t"$1"\t"$3"\t"file}'
    done
    #clean up
    rm -f *.tmp
done
