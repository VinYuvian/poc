[masters]
master ansible_host=${controller0_ip}

[workers]
worker1 ansible_host=${worker0_ip}
worker2 ansible_host=${worker1_ip}