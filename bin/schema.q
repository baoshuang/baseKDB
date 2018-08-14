logPaths:([] time:"p"$(); sym:`$(); location:());
dirtyTables:([tableName:(tables `.)] isDirty:(count tables `.)#0b);
perf:flip`time`sym`subFun`isStart!(();();();"b"$());