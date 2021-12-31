#/bin/bash
rpm = `rpm -qa | grep keepalived`

rpm -qa | grep keepalived
if [ $? -eq 0 ];then
  echo "keeplaived installed! We will be Reinstall!"
  for i in $rpm
  do
    yum -y remove $q
  done
else
  echo "keepalived not install! We will be install!"
fi
