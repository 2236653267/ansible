#/bin/bash
rpm = `rpm -qa | grep docker`

rpm -qa | grep docker
if [ $? -eq 0 ];then
  echo "docker installed! We will be Reinstall!"
  for i in $rpm
  do
    yum -y remove $i
  done
else
  echo "docker not install!"
fi
  
