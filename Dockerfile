FROM centos/systemd:latest
ENTRYPOINT ["/usr/sbin/init"]
EXPOSE 139 445

RUN yum -y install epel-release && \
    yum -y install samba jq && \
    yum clean all && \
    rm -rf /var/cache/yum

ADD createusers.sh /usr/local/sbin/
ADD createusers.service /etc/systemd/system/
ADD createusers /etc/sysconfig/

RUN systemctl enable smb && \
    systemctl enable createusers && \
    mkdir /var/samba/ && \
    chmod ug+rwx /usr/local/sbin/createusers.sh