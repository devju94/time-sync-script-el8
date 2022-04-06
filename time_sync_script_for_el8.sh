#!/bin/bash

CP="/bin/cp"
CHRONY_CONF="/etc/chrony.conf"
NOW=`date +%Y%m%d%H%M%S`
TIME_SERVER="time.bora.net"

# chrony.conf 파일 존재 유무 확인
if [ ! -f ${CHRONY_CONF} ]; then
	echo "${CHRONY_CONF} not exists"
	exit 1
fi

# 설정 확인
check1=`cat ${CHRONY_CONF} | grep "^pool" -c`
check2=`cat ${CHRONY_CONF} | grep "^server" -c`
check3=`cat ${CHRONY_CONF} | grep "^server" | grep "${TIME_SERVER}" | grep "iburst" -c`
if [ "${check1}" -eq 0 ] && [ "${check2}" -eq 1 ]; then
    if [ "${check3}" -eq 1 ]; then
        echo "already set 'server ${TIME_SERVER} iburst'"
        exit 2
    fi
fi

# chrony.conf 파일 백업
${CP} -prf ${CHRONY_CONF} ${CHRONY_CONF}_backup${NOW} 

# pool & server 옵션 모두 삭제
sed -i "/^pool/d" ${CHRONY_CONF}
sed -i "/^server/d" ${CHRONY_CONF}

# server 옵션 추가
sed -i "1 i\server ${TIME_SERVER} iburst" ${CHRONY_CONF}

# timezone 설정
timedatectl set-timezone Asia/Seoul

# chronyd 재시작
systemctl stop chronyd
systemctl start chronyd

# hw 동기화
hwclock -w
hwclock -v

# 완료
echo "completed."
date
