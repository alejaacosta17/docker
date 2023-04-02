# Base Docker image Ubuntu version tag 20.04
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
# Install new updated packages and dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo &&\
    apt-get install -y wget &&\
# Install git
    apt-get install -y git && \
# Install maven
    apt-get install -y maven &&\
# Install postgres
    apt-get install -y postgresql &&\
# Install Java JRE that support almost all Java versions 
    apt-get install -y default-jre
#Install VScode https://code.visualstudio.com/docs/setup/linux 
RUN sudo apt-get install -y wget gpg&& \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg && \
    sudo apt install -y apt-transport-https && \
    sudo apt update && \
    sudo apt install -y code 

#Install .NET on Ubuntu https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2004
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \
    sudo chmod +x ./dotnet-install.sh && \
    ./dotnet-install.sh --version latest && \
    ./dotnet-install.sh --version latest --runtime aspnetcore && \
    ./dotnet-install.sh --channel 7.0
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#set-environment-variables-system-wide set env
RUN export DOTNET_ROOT=$HOME/.dotnet && \
    export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools


