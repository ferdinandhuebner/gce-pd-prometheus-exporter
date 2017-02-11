#!/bin/sh
function term() {
  kill -s SIGKILL -$$
}

trap term SIGTERM SIGINT 
sh /export-gce-pd-stats.sh &
wait $(jobs -p)