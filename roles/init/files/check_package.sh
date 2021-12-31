#/bin/bash
if [ -f /data/boss/kubesphere/rpm.tar.gz ]; then
  tar -xvf /data/boss/kubesphere/rpm.tar.gz -C /data/boss/kubesphere/
else
  echo "ERROR! Not found rpm!"
  exit 1
fi

if [ -d /etc/yum.repos.d/bak ]; then
  mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
else
  mkdir -p /etc/yum.repos.d/bak
  mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
fi
