// set the port
@[system;"p 5012";{-2"Failed to set port to 5012: ",x,
                     ". Please ensure no other processes are running on that port",
                     " or change the port in both the publisher and subscriber scripts.";
                     exit 1}];

commonPath:"common.q";
@[system;"l ",commonPath;{-2"Failed to load tables from common.q ",x," : ",y,
                       ". Please make sure common.q is accessible.";
                       exit 2}[commonPath]];
					 
/init
monitorHandle:.common.connectToMonitor[];

hdbPath:"../hdb";
@[system;"l ",hdbPath;{-2"Failed to load hdb from ",x," : ",y,
                       ". Please make sure u.q is accessible.";
                       exit 2}[hdbPath]];
					   