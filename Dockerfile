FROM centos/systemd:latest
ENTRYPOINT ["/usr/sbin/init"]
EXPOSE 139 445

RUN yum -y install epel-release && \
    yum -y install samba jq && \
    yum clean all && \
    rm -rf /var/cache/yum

ADD createusers.sh /usr/local/sbin/
ADD createusers.service /etc/systemd/system/

RUN systemctl enable smb && \
    systemctl enable createusers && \
    chmod ug+rwx /usr/local/sbin/createusers.sh