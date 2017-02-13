#!/bin/sh
function term() {
  kill -s SIGKILL -$$
}

trap term SIGTERM SIGINT 
sh /loop.sh &
wait $(jobs -p)