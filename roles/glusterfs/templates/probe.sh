#/bin/bash
systemctl status glusterd

if [ $? -eq 0 ];then
{% for hosts in groups['probe'] %}
  gluster peer probe {{ hosts }}
{% endfor %}
else
  echo "Error! glusterd not start!"
  exit 1
fi

