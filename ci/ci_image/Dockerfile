FROM ubuntu:16.10

RUN apt-get update && apt-get install git zip unzip curl wget vagrant file zlib1g-dev libxml2 -y && \
    apt-get clean

# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 &&
RUN \curl -sSL https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c "rvm install 2.2.4"
RUN /bin/bash -l -c "rvm use 2.2.4 --default"
RUN /bin/bash -l -c "rvm 2.2.4 do gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "rvm 2.2.4 do gem install bosh_cli --no-ri --no-rdoc"

RUN ruby --version
