#!/bin/bash

#git rev-list --all | xargs git show -s --format='%ae %ad' | awk '{print $1, $NF}' | sort -nk1 -t ' ' | uniq


SCRIPTNAME="osgint.sh"
SCRIPTVERSION="v0.1"
# Print usage
usage() {
echo -n "$SCRIPTNAME [OPTION]...
main options are described below.
Options:
-h,--help Display this help and exit
--version Displays versions and exits
"
}
version() {
echo -n "$SCRIPTNAME $SCRIPTVERSION (C) 2021. No warranty."
}
# DEPENDENCY: getopt command tool
TEMP=`getopt -o vdh --long help,version -n "$SCRIPTNAME" -- "$@"`
# Note the quotes around ‘$TEMP’: they are essential!
eval set -- "$TEMP"
# default values for options
while true; do
case "$1" in
-h | --help ) usage; exit 0 ;;
--version ) version; exit 0 ;;
-- ) shift; break ;;
* ) break ;;
esac
done
##############################################
### error handling ###
##############################################
func_unexpected() {
echo "Error due to an unexpected error";
echo "Try again or consult the manual";
exit 1;
}
##############################################
### signals ###
##############################################
trap "func_unexpected" 1 # Generic code error

##############################################
### aux functions ###
##############################################

# main body

check_git
echo $?
# exit
exit 0