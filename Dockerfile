FROM centos:7
MAINTAINER rmkn
RUN sed -i -e "s/en_US.UTF-8/ja_JP.UTF-8/" /etc/locale.conf
RUN ln -sf /usr/share/zoneinfo/Japan /etc/localtime 
RUN yum -y update
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo ""

RUN yum -y install epel-release
RUN yum -y install bzip2 gcc gcc-c++ file make httpd php php-mbstring php-mcrypt php-pdo openssl-devel boost-devel pandoc httpd sqlite-devel

ENV PDNS_VERSION 4.0.3

RUN curl -o /tmp/pdns.tar.bz2 -SL https://downloads.powerdns.com/releases/pdns-${PDNS_VERSION}.tar.bz2 \
        && tar jxf /tmp/pdns.tar.bz2 -C /usr/local/src \
	&& cd /usr/local/src/pdns-${PDNS_VERSION} \
	&& ./configure --with-modules="bind gsqlite3" \
	&& make \
	&& make install

RUN curl -o /tmp/poweradmin.tar.gz -SL http://jaist.dl.sourceforge.net/project/poweradmin/poweradmin-2.1.7.tgz \
       && tar xzf /tmp/poweradmin.tar.gz -C /var/www/html/ --strip=1

RUN yum -y install bind-utils iproute

COPY entrypoint.sh /
COPY init.sh /tmp/
RUN /tmp/init.sh

EXPOSE 53 80

CMD ["/usr/local/sbin/pdns_server"]

ENTRYPOINT ["/entrypoint.sh"]

