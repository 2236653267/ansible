#/bin/bash
rpm = `rpm -qa | grep haproxy`

rpm -qa | grep haproxy
if [ $? -eq 0 ];then
  echo "haproxy installed! We will be Reinstall!"
  for i in $rpm
  do
     yum -y remove $1
  done
else
  echo "haproxy not install! We will be install!"
fi
