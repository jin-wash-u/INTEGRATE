# work from latest LTS ubuntu release
FROM ubuntu:16.04

# add metadata to image
LABEL author="Zachary Skidmore"
LABEL description="Integrate:  tool calling gene fusions with exact fusion\
                   junctions and genomic breakpoints by combining RNA-Seq and\
                   WGS data. Built on Xenial (ubuntu 16.04).\

                   USAGE: integrate"

# set the environment variables
ENV integrate_version_a 0.2.6
ENV integrate_version_b 0_2_6

# update and install additional packages
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y curl
RUN apt-get install -y libz-dev
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y libncursesw5-dev

################################################################################
########################### Install Integrate ##################################

RUN curl -L https://sourceforge.net/projects/integrate-fusion/files/INTEGRATE.${integrate_version_a}.tar.gz > /usr/bin/INTEGRATE.${integrate_version_a}.tar.gz
RUN tar -xzf /usr/bin/INTEGRATE.${integrate_version_a}.tar.gz -C /usr/bin/
RUN mkdir /usr/bin/INTEGRATE_${integrate_version_b}/INTEGRATE-build/
RUN cd /usr/bin/INTEGRATE_${integrate_version_b}/INTEGRATE-build/ && cmake ../Integrate/ -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX="/usr/local"
RUN cd /usr/bin/INTEGRATE_${integrate_version_b}/INTEGRATE-build/ && make
RUN cp /usr/bin/INTEGRATE_${integrate_version_b}/INTEGRATE-build/bin/Integrate /usr/local/bin/

CMD ["Integrate"]
