@echo off
cd ..
set BASE_DIR=..
set BIN_DIR=%BASE_DIR%/bin

set TP_SCRIPT=%BIN_DIR%/tp.q
set RDB_SCRIPT=%BIN_DIR%/rdb.q
set MAINT_SCRIPT=%BIN_DIR%/maintenance.q
set MONITOR_SCRIPT=%BIN_DIR%/monitor.q
set HDB_SCRIPT=%BIN_DIR%/hdb.q

start "RDB" /MIN c:\q\w32\q.exe %RDB_SCRIPT%