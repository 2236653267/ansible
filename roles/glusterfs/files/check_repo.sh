#/bin/bash
if [ -d /data/init ]; then
  echo "init copy seccress!"
  if [ -d /etc/yum.repos.d/bak ];then
     cd /etc/yum.repos.d && mv *.repo* bak
  else
     mkdir -p /etc/yum.repos.d/bak && cd /etc/yum.repos.d && mv *.repo* bak
  fi
else
  echo "ERROR! init copy fail!"
fi
