FROM centos/systemd:latest
USER root

RUN yum -y install samba; systemctl enable smb; yum clean all;

ENTRYPOINT ["/usr/sbin/init"]
