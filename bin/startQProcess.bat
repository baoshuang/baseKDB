@echo off
set BASE_DIR=..
set BIN_DIR=%BASE_DIR%/bin

set TP_SCRIPT=%BIN_DIR%/tp.q
set RDB_SCRIPT=%BIN_DIR%/rdb.q
set MAINT_SCRIPT=%BIN_DIR%/maintenance.q
set MONITOR_SCRIPT=%BIN_DIR%/monitor.q
set HDB_SCRIPT=%BIN_DIR%/hdb.q

REM Start Monitor
start "MONITOR" /MIN c:\q\w32\q.exe %MONITOR_SCRIPT%
timeout /T 2 /NOBREAK


REM Start Ticker Plant
echo Starting Ticker Plant in a new Window ...
start "TickerPlant" /MIN c:\q\w32\q.exe %TP_SCRIPT%
timeout /T 1 /NOBREAK

echo.

REM Start RDB
REM echo Starting RDB in a new Window ...
REM start "RDB" /MIN c:\q\w32\q.exe %RDB_SCRIPT%
REM timeout /T 1 /NOBREAK

REM echo.

REM Start CTPs
echo Starting Chained Ticker Plants in new Windows ...

echo.

REM Start Maintenance Plant
echo Starting Maintenance Plant in new Window ...
start "Maintenance" /MIN c:\q\w32\q.exe %MAINT_SCRIPT%
timeout /T 3 /NOBREAK
echo.

REM HDB
REM echo Starting HDB in new Window ...
REM start "HDB" /MIN c:\q\w32\q.exe %HDB_SCRIPT%
start "HDB" /MIN c:\q\w32\q.exe %HDB_SCRIPT%
timeout /T 2 /NOBREAK

echo Start Complete - waiting 5 seconds ...
timeout /T 5 /NOBREAK >NUL