FROM centos/systemd:latest

RUN yum -y install samba; systemctl enable smb; yum clean all;

CMD ["/usr/sbin/init"]
