# 07-IITP-DABT-Analysis
7.데이터 분석-모델 툴

# 메타베이스 설치 백업 및 복구

## **메타베이스 설치 가이드**

1. Docker 설치 확인

```bash
docker ps

```

1. docker 설치가 안되어 있다면 설치 후 진행 (docker 설치가 되어 있다면 3번 진행)
- docker 설치 방법은 아래의 사내 위키 글 참고 [<사내 위키 문서>](<사내 위키 문서>)
1. 메타 베이스 docker image 다운로드

```bash
docker pull metabase/metabase:latest

```

1. docker container 실행

```bash
docker run -d -p 3000:3000 --name metabase metabase/metabase

```

1. 접속 확인
- 메타베이스의 기본 포트는 3000번 포트이므로 서버주소:3000으로 접속 확인 ex) [http://<SERVER_IP>:3000](http://<SERVER_IP>:3000/)

## 🚀 실행 방법

1. 컨테이너 목록 확인

```bash
docker ps -a

```

→ 여기서 `metabase` 라는 이름과 `d9ee671b6b02...` 같은 ID를 확인할 수 있습니다.

1. 컨테이너 시작

```bash
docker start metabase

```

또는

```bash
docker start d9ee671b6b02

```

1. 실행 여부 확인

```bash
docker ps

```

→ `STATUS` 가 `Up` 으로 표시되면 정상 실행 중입니다.

# 🔹 1. H2 DB(기본 내장 DB) 사용하는 경우

### ✅ 백업 절차

1. 컨테이너 중지 (데이터 무결성 확보)
    
    ```bash
    docker stop metabase
    
    ```
    
2. DB 파일 복사
    
    ```bash
    docker cp metabase:/metabase.db ./metabase-backup
    
    ```
    
    → `./metabase-backup/metabase.db.mv.db` 파일이 생김
    
    ⚠️ 주의: H2는 파일 기반이라, 실행 중에 바로 복사하면 깨질 수 있습니다. **꼭 중지 후 복사** 권장합니다. 
    
3. 컨테이너 설정(환경변수, 포트)도 함께 기록
    - `docker inspect metabase > metabase-config.json`
4. 이미지 백업 (선택사항)
    
    ```bash
    docker commit metabase metabase_with_data:backup
    docker save -o metabase_with_data.tar metabase_with_data:backup
    
    < DISK
    ```
    

---

### ✅ 복구 절차

1. 기존 백업 디렉토리 준비
    
    ```bash
    mkdir ./metabase-restore
    cp ./metabase-backup/metabase.db.mv.db ./metabase-restore/
    
    ```
    
2. 새 컨테이너 실행
    
    ```bash
    docker run -d -p 3000:3000 \
      -v $(pwd)/metabase-restore:/metabase.db \
      --name metabase metabase/metabase
    
    ```
    

➡️ 이렇게 하면 기존 데이터로 새 컨테이너가 복원됩니다.
