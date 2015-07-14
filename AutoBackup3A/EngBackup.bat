echo off
rem -----------------------------------------------------------------------------------
rem Filename:    EngBackup.bat
rem Description: Carry out daily backup of Experion Server Data and Configuration
rem -----------------------------------------------------------------------------------
rem Revision:    4
rem Date:        2-Sep-08
rem Author:      Sophie Allen & Stewart Peake
rem Comment:     Rev 1: Updated to store log in ExperionBackupLog directory and use timestamps
rem                     Removed copy from Server B to get databases as it does its own backup
rem		 Rev 2: Added Lantronix DeviceInstaller files to backup
rem		 Rev 3: Made generic for distribution through ARC Team Room
rem	                Added 'REM ####' comments for customisation notes.
rem	                robocopy used for user and data directories
rem	                user directory replaces reportdef directory
rem		 Rev 4: Small changes to robocopy & xcopy commands and appending log files.
rem Requirements: 1) Requires 7-zip installed and path to 7z.exe to be in PATH environment
rem                    variable.  7-zip can be downloaded from www.7-zip.org
rem               2) Should be installed in d:\ExperionBackup directory on Server A
rem               3) d:\ExperionBackupLog directory should be created before running.
rem -----------------------------------------------------------------------------------

REM #### Assumes DD-MM-YYYY format.
REM #### Assumes date separator is "/" or "-".
REM #### Change tokens and order of %%p, %%o and %%n if date format is different.
for /F "tokens=1-2" %%i in ('date /t') do (
   for /F "delims=/- tokens=1-3" %%n in ("%%j") do set BkupDate=%%p_%%o_%%n
)

set Backup=AutoBackup3A
set AutoBackup=EPKSSRV03A
set ExperionBackup=EPKSSRV03A\%BkupDate%
set BkupLogFile=d:\%ExperionBackup%\%BkupDate%_SVRB_LOG.log
set BkupZipFile=d:\%ExperionBackup%\%BkupDate%_SVRB_BKUP.zip
set RCOPYOPTS=/MIR /LOG+:%BkupLogFile%


d:

REM Erase old contents
rem del d:\%AutoBackup%\*.* /Q

REM Build folder structure
mkdir d:\%ExperionBackup%
dir *.* >> %BkupLogFile%
mkdir d:\%ExperionBackup%\Abstract\

cd d:\%ExperionBackup%
echo == Backup Started == >> %BkupLogFile%
date /t >> %BkupLogFile%
time /t >> %BkupLogFile%
echo. >> %BkupLogFile%

rem bckbld -out sdabkup.pnt >> %BkupLogFile%

sleep 2
rem bckbld -out cdabkup.pnt -tag cda >> %BkupLogFile%

sleep 2
del hdwbckup.hdw
rem hdwbckbld -out hdwbckup.hdw >> %BkupLogFile%

sleep 2
REM Copying client files...
REM #### Confirm the abstract and CSS directories below:
robocopy /e c:\ProgramData\Honeywell\Experi~1\client\abstract\ d:\%ExperionBackup%\Abstract\ %RCOPYOPTS%


REM Collecting Experion Server Files...
REM #### Check number of records in your configuration for each fildmp below.
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\stdhist.dmp" -FILENUM 25 -RECORDS 1,5000 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\fasthist.dmp" -FILENUM 24 -RECORDS 1,1000 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\exthist.dmp" -FILENUM 26 -RECORDS 1,1000 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\messages.dmp" -FILENUM 156 -RECORDS 1,1000 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\UserAcronym.dmp" -FILENUM 27 -RECORDS 2881,3880 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\groups.dmp" -FILENUM 143 -RECORDS 1,3000 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\trends.dmp" -FILENUM 11 -RECORDS 1,3000 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\areas.dmp" -FILENUM 7 -RECORDS 1,255 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\reports.dmp" -FILENUM 14 -RECORDS 1,200 -FORMAT HEX
rem "d:\Program Files\Honeywell\Experion PKS\server\run\fildmp" -DUMP -FILE "d:\%ExperionBackup%\Dumps\keyboard.dmp" -FILENUM 4 -RECORDS 1,41 -FORMAT HEX

sleep 2
shheap 1 backup
sleep 2

REM Copying Server Data Files...
robocopy d:\ProgramData\Honeywell\Experion PKS\server\data \%ExperionBackup%\data %RCOPYOPTS%
sleep 5

REM Copying Server Report Definition and other User Files...
robocopy d:\ProgramData\Honeywell\Experion PKS\server\user \%ExperionBackup%\user %RCOPYOPTS%
sleep 5

echo == Copying files to central repository == >> %BkupLogFile%
REM #### Change the path below to a path for network storage of the backup.
rem robocopy /e d:\%ExperionBackup% \\server\ExpBackup\%ExperionBackup% >> %BkupLogFile%

echo == BACKUP COMPLETED == >> %BkupLogFile%
date /t >> %BkupLogFile%
time /t >> %BkupLogFile%
echo. >> %BkupLogFile%

rem Now copy the backup log too!
REM #### Change the path below to a path for network storage of the backup.
rem xcopy %BkupLogFile% \\server\ExpBackup\%ExperionBackup% /Y
xcopy d:\%ExperionBackup% /Y


cd..