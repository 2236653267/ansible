#/bin/bash
if [ -d /data/boss/kubesphere/kubesphere-images ]; then
  echo "pass"
else
  echo "ERROR! Not found kubesphere-images!"
  exit 1
fi

if [ -d /data/boss/kubesphere/rpm ]; then
  echo "Pass"
else
  echo "ERROR! Not found rpm!"
  exit 1
fi

