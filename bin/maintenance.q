// set the port
@[system;"p 5052";{-2"Failed to set port to 5052: ",x,
                     ". Please ensure no other processes are running on that port",
                     " or change the port in both the publisher and subscriber scripts.";
                     exit 1}];

/load common items
commonPath:"common.q";
@[system;"l ",commonPath;{-2"Failed to load tables from common.q ",x," : ",y,
                       ". Please make sure common.q is accessible.";
                       exit 2}[commonPath]];

monitorHandle:.common.connectToMonitor[];
upd:.maint.upd;
.u.end:.maint.end;

// open a handle to the publishers
tpHandle:@[hopen;`::5010;{-2"Failed to open connection to publisher on port 5010: ",x,". Please ensure publisher is running";exit 1}];

// subscribe to the required data
// .u.sub[tablename; list of instruments]
// ` is wildcard for all
 tpHandle (`.u.sub;`logPaths;`);