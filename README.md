Multicraft container with panel and daemon in one.
Used for running one or more easy to use minecraft servers with administration panel and more. 



The container will be created with two locations internally '/mc/panel' and '/mc/multicraft', which should be mounted to maintain config and data for both the server and the web front end.

Create a volume mapping to container path /mc.
 - Map container path to "/mc"
 - Map Container port 80 to whatever you want for the web portal.
 - Map TCP/UDP ports for your game server(s). (Default is 25565 for minecraft but is NOT added by default)


The individual server files can be found internally at '/mc/multicraft/servers/' in their own individual folder as set by within the Multicraft Panel. There are a handful of environmentals which can be set at start up as shown below. If you have purchased a Multicraft licence you should input this into MC_KEY, this will then be updated to allow you to access your full server licencing.

Map the following Variables as needed. (The following are defaulted variables)
- MC_DAEMON_ID="1"
- MC_DAEMON_PW="ChangeMe"
- MC_FTP_IP=""
- MC_FTP_PORT="21"
- MC_FTP_SERVER="y"
- MC_KEY=""
