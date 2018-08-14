/load common items
// set the port
@[system;"p 5050";{-2"Failed to set port to 5050: ",x,
                     ". Please ensure no other processes are running on that port",
                     " or change the port in both the publisher and subscriber scripts.";
                     exit 1}];

commonPath:"common.q";
@[system;"l ",commonPath;{-2"Failed to load tables from common.q ",x," : ",y,
                       ". Please make sure common.q is accessible.";
                       exit 2}[commonPath]];

/set up monitor
connections:([handle:()] time:(); host:(); ip:(); port:(); pid:(); script:(); monitorHandle:(); user:());
reconnect:([] time:enlist .z.p; reConnect:enlist 1b);
 .z.pc:.mon.pc;
 .z.po:.mon.po;

