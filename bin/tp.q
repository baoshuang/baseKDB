// set the port
@[system;"p 5010";{-2"Failed to set port to 5010: ",x,
                     ". Please ensure no other processes are running on that port",
                     " or change the port in both the publisher and subscriber scripts.";
                     exit 1}];

/load common items
commonPath:"common.q";
@[system;"l ",commonPath;{-2"Failed to load tables from common.q ",x," : ",y,
                       ". Please make sure common.q is accessible.";
                       exit 2}[commonPath]];

/init
monitorHandle:.common.connectToMonitor[];
.u.i:0;
logHandle:0b;
.tp.openLogHandle[];
.u.upd:.tp.upd;

