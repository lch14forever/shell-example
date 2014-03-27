usage() { echo "Usage: $0 [-d <DELIMITER>] [-f <FIELD_NUMBER>] [-C <CHROMOSOME_NUMBER>] [-S <STARTING_POSITION>] [-E <ENDING_POSITION>] [FILE]" 1>&2; exit 1; }
 
DELIMITER=$(echo -e "\t")
CHROMOSOME='chr1'
FIELD_NUMBER=1
PO_START=1
PO_END=249250621

while getopts ":d:f:C:S:E:" opt; do
# The very first ":" disables error handling
# The ":"s after each option asks for a value
    case $opt in
	d)
	    DELIMITER=${OPTARG};;
	f)
	    FIELD_NUMBER=${OPTARG};;
	C)
	    CHROMOSOME=${OPTARG};;
	S)
	    PO_START=${OPTARG};;
	E)
	    PO_END=${OPTARG};;
	*)
	    usage;;
    esac
done


shift $(($OPTIND -1))
# Shift the arguments so that $1 is the additional args (the file name)

grep "$CHROMOSOME" $1 > tmp.$1

cut -d"$DELIMITER" -f $FIELD_NUMBER tmp.$1 | sed "s/$CHROMOSOME://" | sed "s/-/$DELIMITER/" | paste -d"$DELIMITER"  - tmp.$1 | awk -v ps=$PO_START -v pe=$PO_END '($1>=ps && $2<=pe) {print $0}' | sort -k 1 | cut -d"$DELIMITER" -f 3- >selected
rm tmp.$1
