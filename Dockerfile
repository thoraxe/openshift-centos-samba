FROM centos/systemd:latest
USER root

RUN yum -y install samba; systemctl enable smb; yum clean all;

ENTRYPOINT ["/usr/sbin/init"]
EXPOSE 139
EXPOSE 445
