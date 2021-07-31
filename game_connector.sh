#!/bin/bash
# Forward traffic from this node to SERVER
# This is built to support telnet on the remote node.
# See games_node.xinetd for the service that
# calls this script

SERVER=gamepi.lan
PORT=63000

handle_trap() {
    echo "Handling signal..." >> log.txt
    exit 1
}

trap handle_trap SIGHUP SIGINT SIGTERM

cd /opt/games/

echo "Connecting to server..." >> log.txt
# Forward input to netcat. Had to pull out \r to get things
# behaving
cat - | sed -u 's/\r//' | netcat -N -q0 ${SERVER} ${PORT}
echo "Disconnected from server" >> log.txt

exit 0
