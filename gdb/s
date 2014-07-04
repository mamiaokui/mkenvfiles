declare -x ucpid=`adb shell ps | grep "UCM" | grep -v "UCMobile:" | grep -v "UCMobile/" | grep -v ":" | awk '{print $2}' `
echo $ucpid
ucpid="/data/local/tmp/gdbserver\ --attach\ \:5039\ $ucpid"
echo $ucpid
adb shell "su -c $ucpid"