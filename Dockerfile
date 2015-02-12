#################################################
# Debian with added pure-ftpd Server.
# Uses pureftpd.pdb on default and virtual users.
#################################################

# Using latest Ubuntu image as base
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

# install dependancies
RUN apt-get update && apt-get install -y pure-ftpd

# setup ftpgroup and ftpuser
RUN groupadd ftpgroup
RUN useradd -g ftpgroup -d /dev/null -s /etc ftpuser

RUN echo yes > /etc/pure-ftpd/conf/ChrootEveryone
RUN echo no > /etc/pure-ftpd/conf/PAMAuthentication
RUN echo no > /etc/pure-ftpd/conf/UnixAuthentication
RUN echo "10" > /etc/pure-ftpd/conf/MaxClientsNumber
RUN echo yes > /etc/pure-ftpd/conf/CreateHomeDir
RUN cd /etc/pure-ftpd/auth; ln -s ../conf/PureDB 50pure

# startup
CMD /usr/sbin/pure-ftpd -l puredb:/etc/pure-ftpd/pureftpd.pdb -x -E -j -R

EXPOSE 21/tcp
