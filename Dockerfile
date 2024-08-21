# SPDX-FileCopyrightText: 2024 nacky823 youjiyongmu4@gmail.com
# SPDX-License-Identifier: Apache-2.0

FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

ARG USERNAME="mugimaru"
ARG UID_AND_GID=1234

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    apt-utils \
    bash-completion \
    curl \
    eog \
    git \
    gnupg2 \
    lsb-release \
    network-manager \
    python3 \
    python3-pip \
    python3-tk \
    python3-venv \
    sudo \
    terminator \
    tree \
    tzdata \
    unzip \
    vim \
    wget \
    x11-apps \
    xterm && \
    apt-get autoremove -y -qq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV USERNAME=$USERNAME
ENV USER=$USERNAME
RUN groupadd -g $UID_AND_GID $USERNAME && \
    useradd -ms /bin/bash -u $UID_AND_GID -g $UID_AND_GID -d /home/$USERNAME $USERNAME && \
    chown -R $USERNAME:$USERNAME /home/$USERNAME && \
    echo "$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV TZ="Asia/Tokyo"
RUN echo $TZ > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

USER $USERNAME
WORKDIR /home/$USERNAME

COPY setup.sh /home/$USERNAME/
RUN . /home/$USERNAME/setup.sh

COPY install_packages.bash /home/$USERNAME/

CMD ["/bin/bash"]