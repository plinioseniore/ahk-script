echo off
rem -----------------------------------------------------------------------------------
rem Filename:    RunExport.bat
rem Description: Carry out daily export of Experion Control Builder Configuration
rem -----------------------------------------------------------------------------------
rem Revision:    4 
rem Date:        23-Oct-07
rem Author:      Stewart Peake
rem Comment:     Rev 1: Original Program + added Checkpoint files to backup
rem              Rev 2: Updated to include exports of Assets and AlarmGroups.
rem              Rev 3: Updated to delete allcmslist.sl file which was getting bigger each run
rem              Rev 4: Updated to be more generic for release on ARC Teamroom.
rem              Rev 5: Added /Y option to xcopy commands.
rem              Rev 6: Added RCOPYOPTS definition to correct copy of checkpoint files.
rem              Rev 7: Changed Alarm Group export to include all.
rem Requirements: 1) Requires 7-zip installed and path to 7z.exe to be in PATH environment
rem                    variable.  7-zip can be downloaded from www.7-zip.org
rem               2) Must be installed in d:\%ExperionBackup% on Server B. 
rem               3) Each export & log directory must be created before batch file is run:
rem                    d:\%ExperionBackup%\ERDB_Export
rem                    d:\%ExperionBackup%\Assets_Export
rem                    d:\%ExperionBackup%\AlmGrps_Export
rem                    d:\ExperionBackupLog
rem               4) Utilises the following files which must be in same directory:
rem                    UnicodeExportList.bat
rem                    AlmGrpsList.sql
rem                    AssetsList.sql
rem                    ExportList.sql
rem -----------------------------------------------------------------------------------

REM #### Assumes DD-MM-YYYY format.
REM #### Assumes date separator is "/" or "-".
REM #### Change tokens and order of %%p, %%o and %%n if date format is different.

for /F "tokens=1-2" %%i in ('date /t') do (
   for /F "delims=-/ tokens=1-3" %%n in ("%%j") do set BkupDate=%%p_%%o_%%n
)

set Backup=AutoBackup3B
set AutoBackup=EPKSSRV03B
set ExperionBackup=EPKSSRV03B\%BkupDate%
set BkupLogFile=d:\%ExperionBackup%\%BkupDate%_SVRB_LOG.log
set BkupZipFile=d:\%ExperionBackup%\%BkupDate%_SVRB_BKUP.zip
set RCOPYOPTS=/MIR /R:3 /W:5 /NP /LOG+:%BkupLogFile%

d:

REM Erase old contents     >> %BkupLogFile%
rem del d:\%AutoBackup%\*.* /Q /S >> %BkupLogFile%

REM Build folder structure >> %BkupLogFile%
mkdir d:\%ExperionBackup%  
dir *.* >> %BkupLogFile%   >> %BkupLogFile%
mkdir d:\%ExperionBackup%\ERDB_Export\     >> %BkupLogFile%
mkdir d:\%ExperionBackup%\Assets_Export\   >> %BkupLogFile%
mkdir d:\%ExperionBackup%\AlmGrps_Export\  >> %BkupLogFile%
mkdir d:\%ExperionBackup%\Checkpoint\      >> %BkupLogFile%
mkdir d:\%ExperionBackup%\CheckpointBase\  >> %BkupLogFile%

cd d:\%ExperionBackup%    >> %BkupLogFile%
echo == Backup Started == >> %BkupLogFile%
date /t >> %BkupLogFile%
time /t >> %BkupLogFile%
echo. >> %BkupLogFile%

echo --------- EXPORT CMs ------------------------------------------------- >> %BkupLogFile%
rem The following check ensures the "del *.*" does not occur in the wrong directory!
if exist d:\%ExperionBackup%\ERDB_Export\nul (
d:
del d:\%ExperionBackup%\*.* /Q /S >> %BkupLogFile%
del d:\%AutoBackup%\allcmslist.sl /Q >> %BkupLogFile%
del d:\%AutoBackup%\allcmslist.txt /Q >> %BkupLogFile%
cd \%ExperionBackup%
osql -d ps_erdb -E -i d:\%Backup%\ExportList.sql -o d:\%ExperionBackup%\ERDB_Export\allcmslist.txt -n -h >> %BkupLogFile%
cmd.exe /U /C d:\%Backup%\UnicodeExportList.bat d:\%ExperionBackup%\ERDB_Export\allcmslist.txt d:\%ExperionBackup%\ERDB_Export\allcmslist.sl
ixptool SP d:\%ExperionBackup%\ERDB_Export  >> %BkupLogFile%
ixptool EXPORT "<allcmslist" >> %BkupLogFile%
) else ( echo Export Backup Directory does not exist >> %BkupLogFile% )

echo --------- EXPORT ASSETS ---------------------------------------------- >> %BkupLogFile%
if exist d:\%ExperionBackup%\Assets_Export\nul (
d:
del d:\%ExperionBackup%\Assets_Export\*.* /Q /S >> %BkupLogFile%
cd \%ExperionBackup%
osql -d epks_emdb -E -i d:\%Backup%\AssetsList.sql -o d:\%ExperionBackup%\Assets_Export\assetslist.txt -n -h >> %BkupLogFile%
cmd.exe /U /C d:\%Backup%\UnicodeAssetList.bat d:\%ExperionBackup%\Assets_Export\assetslist.txt d:\%ExperionBackup%\ERDB_Export\assetslist.sl
ixptool -PROJ4 SP d:\%ExperionBackup%\Assets_Export  >> %BkupLogFile%
ixptool -PROJ4 XP "<assetlist" >> %BkupLogFile%
) else ( echo Assets Backup Directory does not exist >> %BkupLogFile% )

echo --------- EXPORT ALARM GROUPS ---------------------------------------- >> %BkupLogFile%
robocopy /e d:\%Backup%\AlmGrp.sl d:\%ExperionBackup%\AlmGrps_Export %RCOPYOPTS%
set AlmGrpSlFile="<AlmGrp.sl"
if exist d:\%ExperionBackup%\AlmGrps_Export\nul (
d:
del d:\%ExperionBackup%\AlmGrps_Export\*.* /Q /S >> %BkupLogFile%
cd \%ExperionBackup%
ixptool -PROJ4 SP d:\%ExperionBackup%\AlmGrps_Export  >> %BkupLogFile%
ixptool -PROJ4 XP %AlmGrpSlFile%  >> %BkupLogFile%
) else ( echo AlmGrps Backup Directory does not exist >> %BkupLogFile% )

REM Copying Quick Builer files...
robocopy /e C:\ProgramData\Honeywell\Experi~1\Server\data\qdb d:\%ExperionBackup%\QDB %RCOPYOPTS%

REM Copying Checkpoint files...
robocopy /e c:\ProgramData\Honeywell\Experi~1\Checkpoint\ d:\%ExperionBackup%\Checkpoint %RCOPYOPTS%

REM Copying Checkpoint Base files...
robocopy /e c:\ProgramData\Honeywell\Experi~1\CheckpointBase d:\%ExperionBackup%\CheckpointBase %RCOPYOPTS%

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