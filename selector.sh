#!/bin/bash
# This is the entry point on the system hosting games. To call this 
# script see the games.xinetd file.
#
TERM=vt52
LOGFILE=selector_log.txt

ZORK_CMD="/opt/games/zork/zork.sh"
ZORK2_CMD="/opt/games/zork2/zork2.sh"

handle_trap() {
    echo "Handling signal..." >> ${LOGFILE}
    exit 1
}

trap handle_trap SIGHUP SIGINT SIGTERM

# "packet" mode is built to interact with bpq32. The telnet mode in bpq
# will send the user call sign right after connection... Read that up...
if [ "$1" = "packet" ]; then
    read CALL
    # Pick a pretty dumb term. This will prevent too many control characters
    # as those may not (probably wont) get processed correctly by the users 
    # terminal
    export TERM="vt52"
else
    CALL="guest"
fi

cd /opt/games/


echo -n `date` >> ${LOGFILE}
echo " User ${CALL} connected" >> ${LOGFILE}

while [ true ]; do
    echo " Welcome ${CALL} to the game server"
    echo "+==================================+"
    echo " Note: This is a work in progress. If you bump into any issues,"
    echo " let me know. If you use the 'save' command, please use your "
    echo " callsign as the save file name to prevent clobbering others."
    echo ""
	echo "Current options are"
    echo "   ZORK, ZORK2"
    echo "Type QUIT to leave"
	echo -n "Enter selection> "
	read SELECTION


	case ${SELECTION^^} in

		ZORK)
            echo -n `date` >> ${LOGFILE}
            echo " ZORK" >> ${LOGFILE}
            ${ZORK_CMD}
            ;;

        ZORK2)
            echo -n `date` >> ${LOGFILE}
            echo " ZORK2" >> ${LOGFILE}
            ${ZORK2_CMD}
            ;;

        QUIT)
            echo -n `date` >> ${LOGFILE}
            echo " User ${CALL} disconnected" >> ${LOGFILE}
            
            exit 0
            ;;

        *)
            echo "Huh? selection=${SELECTION}"
            ;;

    esac
done
		  

echo -n `date` >> ${LOGFILE}
echo " OH NO... we shouldn't get here...!!!" >> ${LOGFILE}

exit 255
