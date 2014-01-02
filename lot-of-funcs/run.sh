./merge.sh ./pos/*.txt | sed 's/\.\/pos\///' | sed 's/.txt//' > ./pos/merged_pos.txt
./merge.sh ./neg/*.txt | sed 's/\.\/neg\///' | sed 's/.txt//' > ./neg/merged_neg.txt
