**Redhat Enterprise Linux 8, CentOS8, RockyLinux8 등**

**chrony를 시간동기화툴로 사용하는 리눅스 서버에서**

**time.bora.net 타임서버로 시간 동기화**



``` shell
git clone https://github.com/devju94/time-sync-script-el8

cd time-sync-script-el8

# 실행권한 추가 후 스크립트 실행
chmod 755 time_sync_script_for_el8.sh
./time_sync_script_for_el8.sh
```



***

* 이미 설정된 경우 스크립트 실행 방지됨
* 설정 시 원본 chrony.conf 파일 백업됨
