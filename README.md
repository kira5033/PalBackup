# PalBackup

簡易備份腳本，需搭配Windows工作排程器

## 存檔路徑
請直接將要備份的路徑找出來並設定上去
```batch
set WORKDIR="D:\Steam\steamapps\common\PalServer\Pal\Saved\SaveGames\0"
```

## 備份路徑
設定你的備份路徑
```batch
set BACKUPDIR="D:\Steam\steamapps\common\PalServer\Backup"
```

## (option)Log檔名
設定Log檔名，可使用預設即可
```batch
set BACKUP_LOG=00_backup_log.txt
```

## 備份保留天數
```batch
set KEEPFILEDAY=7
```