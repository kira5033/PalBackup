@echo off
setlocal enabledelayedexpansion

:: 設定存檔路徑
set WORKDIR="D:\Steam\steamapps\common\PalServer\Pal\Saved\SaveGames\0"
:: 設定備份路徑
set BACKUPDIR="D:\Steam\steamapps\common\PalServer\Backup"
:: 設定Log名稱
set BACKUP_LOG=00_backup_log.txt
:: 存檔保留天數
set KEEPFILEDAY=7

:: 設定時間參數
set CUR_YYYY=%date:~0,4%
set CUR_MM=%date:~5,2%
set CUR_DD=%date:~8,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%
set TEMPFOLDER=%CUR_YYYY%_%CUR_MM%_%CUR_DD%_%CUR_HH%_%CUR_NN%_%CUR_SS%
set TIMESTAMP=%CUR_YYYY%-%CUR_MM%-%CUR_DD% %CUR_HH%:%CUR_NN%:%CUR_SS%

:: 檢查備份資料夾是否存在，不存在則建立
if not exist "%BACKUPDIR%\" (
    mkdir "%BACKUPDIR%\"
)

:: 開始進行備份
echo [%TIMESTAMP%] Start backup >> "%BACKUPDIR%\%BACKUP_LOG%"
mkdir "%BACKUPDIR%\%TEMPFOLDER%"
xcopy "%WORKDIR%" "%BACKUPDIR%\%TEMPFOLDER%" /E /Y >> "%BACKUPDIR%\%BACKUP_LOG%"
powershell -Command "(Get-Item '%BACKUPDIR%\%TEMPFOLDER%').LastWriteTime = Get-Date('%TIMESTAMP%')"

:: 確認有備份內有無檔案
FORFILES /P "%BACKUPDIR%\%TEMPFOLDER%" /C "cmd /c if @isdir == TRUE echo @path"
if %errorlevel% NEQ 0 (
    echo [%TIMESTAMP%] No files or directories found >> "%BACKUPDIR%\%BACKUP_LOG%"
) else (
    echo [%TIMESTAMP%] Backup success >> "%BACKUPDIR%\%BACKUP_LOG%"
)

:: 移除舊備份
echo [%TIMESTAMP%] Remove old backup >> "%BACKUPDIR%\%BACKUP_LOG%"
FORFILES /P "%BACKUPDIR%" -D -%KEEPFILEDAY% /C "cmd /c if @isDir == TRUE echo @path & rd /s /q @path" >> "%BACKUPDIR%\%BACKUP_LOG%"
echo [%TIMESTAMP%] Done >> "%BACKUPDIR%\%BACKUP_LOG%"

endlocal