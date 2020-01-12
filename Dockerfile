FROM ubuntu:18.04

ENV HOME=/alvitr \
  DEBIAN_FRONTEND=noninteractive \
  STARTUPDIR=/dockerstartup \
  INST_SCRIPTS=/alvitr/install \
  NO_VNC_home=/alvitr/noVNC

ENV VERTUALGL_VERSION=2.6.3

ENV http_proxy='http://172.20.20.104:8080'
ENV https_proxy='http://172.20.20.104:8080'

WORKDIR ${HOME}

# add files
ADD ./src/xfce ${HOME}/
ADD ./src/scripts ${STARTUPDIR}/
ADD ./src/set_user_permission.sh ${INST_SCRIPTS}/

RUN apt update && \
  # install some tools
  apt install -y glmark2 git wget curl supervisor xterm libnss-wrapper gettext build-essential libglu1-mesa libncursesw5-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl libbz2-dev libreadline-dev && \
  # VirtualGL
  curl -L "https://sourceforge.net/projects/virtualgl/files/${VERTUALGL_VERSION}/virtualgl_${VERTUALGL_VERSION}_amd64.deb" -o virtualgl_${VERTUALGL_VERSION}_amd64.deb &&\
  dpkg -i virtualgl*.deb && \
  vglserver_config -config +s +f -t && \
  # config setup
  chmod +x -v ${INST_SCRIPTS}/set_user_permission.sh && \
  ${INST_SCRIPTS}/set_user_permission.sh ${STARTUPDIR} ${HOME} && \
  # clean up
  apt-get clean -y

USER 0
CMD /bin/bash
