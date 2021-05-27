#!/bin/bash

#git rev-list --all | xargs git show -s --format='%ae %ad' | awk '{print $1, $NF}' | sort -nk1 -t ' ' | uniq


SCRIPTNAME="osgint.sh"
SCRIPTVERSION="v0.1"

# Default values
DIRECTORY='./'
FILTER='.*'

# Print usage
usage() {
echo -n "$SCRIPTNAME [OPTION]...
main options are described below.
Options:
-h,--help Display this help and exit
-v,--version Displays versions and exits
-d,--directory Directory to scan, working directory if not set
-e,--extended Displays an extended output
"
}
version() {
echo "$SCRIPTNAME $SCRIPTVERSION (C) 2021. No warranty."
}
# DEPENDENCY: getopt command tool
TEMP=`getopt -o hvd:e --long help,version,directory:,extended -n "$SCRIPTNAME" -- "$@"`
# Note the quotes around ‘$TEMP’: they are essential!
eval set -- "$TEMP"
# default values for options
while true; do
case "$1" in
-h | --help ) usage; exit 0 ;;
-v | --version ) version; exit 0 ;;
-d | --directory ) DIRECTORY=$2; shift 2;;
-e | --extended ) EXTENDED="true"; shift 1;;
-- ) shift; break ;;
* ) break ;;
esac
done
##############################################
### error handling ###
##############################################
func_unexpected() {
echo "There is no git repository";
exit 1;
}
##############################################
### signals ###
##############################################
trap func_unexpected 1 # Generic code error

##############################################
### aux functions ###
##############################################
check_git(){
  git rev-parse --resolve-git-dir $DIRECTORY.git &> /dev/null;
}

user_commits(){
    
    return 5;
}

# main body

if ! check_git; then
    exit 1
fi

if [ -z $EXTENDED ]; then
    git rev-list --all | xargs git show -s --format='%ae %ad' | awk '{print $1, $NF}' | sort -nk1 -t ' ' | uniq
else
    git rev-list --all | xargs git show -s --format='%ae %ad' | awk '{print $1, $NF}' | sort -nk1 -t ' ' | uniq -c | while read -r line;do
        echo $line;
    done
fi


# exit
exit 0