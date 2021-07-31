# packet_games
Set up for hosting text games on bpq32 node

This setup works with the packet node and game server running on different hosts.
There are two sets of files in this project an xinetd service and script for the bpq node, and the xinetd service and script for the game server.
The game server is setup so that the game service runs under a very constrained user account that is only able to run the game selector.
