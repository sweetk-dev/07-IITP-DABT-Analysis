
# Backup Image 
#
#docker save는 컨테이너의 데이터(예: 설정, DB 등) 는 포함하지 않습니다.
#즉, metabase.db 같은 내부 데이터는 별도 백업해야 합니다.
#Metabase의 경우, 데이터베이스 파일은 보통 컨테이너 내부의
#/metabase.db 또는 외부 볼륨(/data/metabase)에 있습니다.

docker save -o metabase_image_backup.tar metabase/metabase
