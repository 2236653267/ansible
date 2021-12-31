#!/bin/bash
#需要安装heketi-client
type heketi-cli 2>&1> /dev/null
if [ $? -ne 0 ];then
  yum -y install heketi-client 2>&1> /dev/null
fi
#比对差异vol
test -e ~/k8s_vol&&rm -f ~/k8s_vol
test -e ~/heketi_vol&&rm -f ~/heketi_vol
sc_url=`kubectl get sc -o yaml| grep 'resturl: http' | awk -F '//' '{print $2}'`
kubectl get pv -o yaml |grep path|grep -v '{}' | awk -F ':' '{print $2}' | awk -F '_' '{print $2}' > ~/k8s_vol
heketi-cli -s http://$sc_url volume list | awk '{print $3}' | awk -F ':' '{print $2}' | awk -F '_' '{print $2}' > ~/heketi_vol
diff=`sort ~/heketi_vol ~/k8s_vol |uniq -u`
echo -e "\033[32m查询到差异vol：$diff\033[0m"
read -p "是否删除(yes/no)" choose 
if [ $choose == yes ];then
     #执行删除异常vol
    for i in $diff
    do
        heketi-cli -s http://$sc_url volume delete $i 2>&1> /dev/null
        echo -e "\033[32m$i已删除 \033[0m"
    done
    test -e ~/k8s_vol&&rm -f ~/k8s_vol
    test -e ~/heketi_vol&&rm -f ~/heketi_vol
else
    exit 1
fi
