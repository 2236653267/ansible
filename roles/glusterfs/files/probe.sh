#/bin/bash
systemctl status glusterd

if [ $? -eq 0 ];then
  gluster peer probe master2
  gluster peer probe master3
  gluster peer probe node1
else
  echo "Error! glusterd not start!"
  exit 1
fi

