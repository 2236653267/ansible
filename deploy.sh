#/bin/bash
function usage() {
 cat <<EOF
$0 <options>

--help                                show this help
--g                                   <持久化存储的ip>
--b                                   <keepalived+haproxy的>
--v                                   <VIP_ADDR>
--m                                   <K8S_MASTER_IPADDR>
--n                                   <K8S_NODE_IPADDR>   
install                               <use ansible deploy k8s-cluster!> 
EOF
}

function parseOptions() {
  TEMP=`getopt -o 'h' -l '\
help,\
g:,\
b:,\
v:,\
m:,\
n:,\
install:.\
' -- "$@"`

  eval set -- "$TEMP"
  local reset_flag=0
  while true; do
    case "$1" in
      -h|--help) usage; exit 0 ;;
      --g) GLUSTERFS_IPADDR=$2; shift 2 ;;
      --b) LB_IPADDR=$2; shift 2 ;;
      --v) VIP_ADDR=$2; shift 2 ;;
      --m) K8S_MASTER_IPADDR=$2; shift 2 ;;
      --n) K8S_NODE_IPADDR=$2; shift 2 ;;
      --) shift; break ;;
      *) echo "error!"; usage; exit 1 ;;
    esac
  done
  
  if [ "x$GLUSTERFS_IPADDR" != "x" ]; then
     echo "[glusterfs]" >> /tmp/test/log
  fi

  for i in $GLUSTERFS_IPADDR
  do
    if [[ $i =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then   
        OIFS=$IFS
        IFS='.'
        ip=($i)
        IFS=$OIFS
        if [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]; then
           echo 'ok' > /dev/null
           stat=0
        else
           echo "$i is bad!"
           stat=1
        fi
    else
      echo "$i is bad!"
      stat=1
    fi
    if [ $stat -eq 0 ]; then
      echo $i >> /tmp/test/log
    fi
  done

  if [ "x$K8S_MASTER_IPADDR" == "x" ]; then
     echo "ERROR! K8S_MASTER_IPADDR is a must!"
     usage
     exit 1
  fi


  if [ "x$K8S_NODE_IPADDR" == "x" ]; then
     echo "ERROR! K8S_NODE_IPADDR is a must!"
     usage
     exit 1
  fi

}


function main() {
     parseOptions "$@"
}

main "$@"
