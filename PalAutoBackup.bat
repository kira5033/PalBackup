@echo off

@rem 設定PalServer路徑
set WORKDIR=D:\Steam\steamapps\common\PalServer
@rem 設定備份路徑
set BACKUPDIR=D:\Steam\steamapps\common\PalServer\Backup
@rem 設定備份檔案
set BACKUP_LOG=%BACKUPDIR%\00_backup_log.txt

@rem 設定時間參數
set CUR_YYYY=%date:~0,4%
set CUR_MM=%date:~5,2%
set CUR_DD=%date:~8,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%
set SUBFILENAME=%CUR_YYYY%_%CUR_MM%_%CUR_DD%_%CUR_HH%_%CUR_NN%_%CUR_SS%

@rem 檢查備份資料夾是否存在
if not exist %BACKUPDIR%\ (mkdir %BACKUPDIR%\)

@rem 開始進行備份
echo Start Backup >> %BACKUP_LOG%
echo Create Folder - %SUBFILENAME% >> %BACKUP_LOG%
mkdir %BACKUPDIR%\%SUBFILENAME%
xcopy %WORKDIR%\Pal\Saved\SaveGames\0 %BACKUPDIR%\%SUBFILENAME% /E >> %BACKUP_LOG%
echo Finish Backup >> %BACKUP_LOG%