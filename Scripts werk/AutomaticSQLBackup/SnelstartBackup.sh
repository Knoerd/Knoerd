#!/bin/bash

#mount voor backups     sudo mount -t cifs "//weja-nas01.local/weja administratie/SnelStart/Snelstart 12/backupsqllinux" /mnt/snelstartsqlbackup -o credentials=/home/sjoerd/.smbcredentials,uid=sjoerd,gid=sjoerd


echo Beginen met de backup van Snelstart

#Begin bestandsnaam en locatie instellen
backuplocatie="/mnt/snelstartsqlbackup"
tijdelijkebackuplocatie=TijdelijkVoorBackup/
serverlocatie=/var/opt/mssql/data/
datumentijd=$(date +"%d_%m_%Y_%H_%M_%S")
bestandsnaam="SnelstartSQL_Backup_$datumentijd.bak"
#Einde bestandsnaam en locatie instellen

#Begin backup van Snelstart SQL database maken
sqlcmd -S localhost -U sa -P SnelstartSQL7031! -Q "Backup Database WejaSnelstart001TEST To Disk='$tijdelijkebackuplocatie$bestandsnaam'"
#Einde backup van Snelstart SQL database maken

# Bestand verplaatsen naar NAS
mv -v "$serverlocatie$tijdelijkebackuplocatie$bestandsnaam" "$backuplocatie"

# Rem Begin Als er meer dan 30 Backups zijn de oudste verwijderen
# set MinimaleBackups=30
# set count=0
# for %%x in (*.bak) do set /a count+=1

# DIR *.bak /A-D /OD /B > LijstVoorVerwijderen.txt

# set /p TeVerwijderenBestand=<LijstVoorVerwijderen.txt

# if %count% gtr %MinimaleBackups% (
#   del /s /q %TeVerwijderenBestand%
# ) else (
#   echo Nog geen 30 backups	
# )

# del /s /q LijstVoorVerwijderen.txt

# Rem Einde Als er meer dan 30 Backups zijn de oudste verwijderen

# echo De backup van Snelstart is voltooid

# pause
