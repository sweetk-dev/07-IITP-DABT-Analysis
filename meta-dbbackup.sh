
#DB Backup 파일 복사
docker cp metabase:/metabase.db ./metabase_db_backup.db

# Recovery Start DB  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# mkdir ./metabase-restore
#cp ./metabase-backup/metabase.db.mv.db ./metabase-restore/
#docker run -d -p 3000:3000 \
#  -v $(pwd)/metabase-restore:/metabase.db \
#  --name metabase metabase/metabase
