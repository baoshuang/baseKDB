.common.perfMon:.[{[fun;subFun;isStr]`perf insert (.z.P;fun;subFun;isStr)}];

/set console output width and height
system "c 500 500";
show "Port: ",string system "p";

/load table schemas
symPath:"schema.q";
@[system;"l ",symPath;{-2"Failed to load tables from schema.q ",x," : ",y,
                       ". Please make sure schema.q is accessible.";
                       exit 2}[symPath]];

/load u.q
uPath:"u.q";
@[system;"l ",uPath;{-2"Failed to load u.q from ",x," : ",y,
                       ". Please make sure u.q is accessible.";
                       exit 2}[uPath]];

jsonPath:"json.k";
@[system;"l ",jsonPath;{-2"Failed to load json.k from ",x," : ",y,
                       ". Please make sure json.k is accessible.";
                       exit 2}[jsonPath]];

/web handle management
tblCsv:{"\\n" sv .h.cd x};
.ws.handles:()!();
.z.ws:{ x:value -9!x;
        0N!.z.w;
        .ws.handles[`int$.z.w]::();
        0N!.ws.handles;
        neg[.z.w] -8!$[(type x) in 98 99h;    (`table;tblCsv[x]);    (`result;x)]
    };

/set compression settings
.z.zd:17 2 6;

/initialise .u
.u.init[];

/common monitor function
.common.connectToMonitor:{@[hopen;`::5050;{-2"Failed to open connection to monitor on port 5050: ", x,". Please ensure the monitor is running";exit 1}]};

/ticker plant
.tp.openLogHandle:
	{[]	.common.perfMon (`.tp.openLogHandle; `; 1b);
        if[logHandle; hclose logHandle; .u.pub[`logPaths; (.z.p; `tpLog; logPath)]; ];
        startDate::string .z.d;
        startTime::string `time$.z.p;
        startPort::system "p";
        logCount::.u.i;
        logHour::`hh$.z.p;
        logTime::.z.p;
        logPath::`$"" sv string (`$":../logs/"),startDate,"_",startPort,"_",logHour,"_","." sv ":"vs startTime;
        logPath set ();
        logHandle::hopen logPath;
        show logPath;
		show logHandle;
        .common.perfMon (`.tp.openLogHandle; `logHandleOpened; 0b);
    };

.tp.upd:
	{[t;x]
        x:update time:.z.P from x;
        if[logHandle; logHandle enlist (`upd; t; x);
            .u.pub[t; x];
            .u.i+:1;
        ];
        if[not ((.z.p<logTime+00:10:00.00) and (.u.i<logCount+3000));
            .tp.openLogHandle[];
        ];
        :.u.i;
    };
	
/maint plant
.maint.upd:{[TAB;DATA]
        show count TAB;
        $[TAB=`logPaths;.maint.processTpLog[last DATA];TAB insert DATA];
        show count TAB;
		};

.maint.processTpLog:{
        .common.perfMon (`.maint.processTpLog;`;1b);
        show "started processTpLog";
        -11!x;
        show "ended processTpLog:";
        .common.perfMon (`.maint.processTpLog;`replayComplete;0b);
        show "starting HDB update";
        .u.end[];
        show "ended HDB update";
        .common.perfMon (`.maint.processTpLog;`hdbComplete;0b);
        -19!(x;x;17;2;6);
        .common.perfMon (`.maint.processTpLog;`logZipComplete;0b);
		};
		
.maint.end:{
        .common.perfMon (`.maint.end;`;1b);
        toHdb:raze {x,'distinct `date$x[`time]} each (tables `.)  where any each (cols each tables `.) in `time;
        .[{[TAB;DATE] (`$"" sv string (`$":../hdb/"),DATE,"/",TAB,"/") upsert .Q.en[`:../hdb;] `sym xcols select from TAB where time.date=DATE}] each toHdb;
        .common.perfMon (`.maint.end;`toHDB;0b);
        {delete from x} each tables `.;
        .common.perfMon (`.maint.end;`clearTables;0b);
        .Q.gc[];
        .common.perfMon (`.maint.end;`gc;0b);
		};

/monitor
 .mon.pc:{a:exec last script from connections where handle=x;system ("start \"",(string a),"\" /MIN c:/q/w32/q.exe ",(string a)," -s 6")};
 .mon.po:{`connections upsert (x,x "(.z.p;.z.h;`$\".\" sv string `int$0x0 vs .z.a;system \"p\";.z.i;.z.f;.z.w;.z.u)"); show `$("New Connection Added at: ",string .z.P); show connections;};
