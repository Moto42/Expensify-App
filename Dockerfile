FROM ubuntu:24.04 AS base_dependencies
# Stage for the basic dependencies that will rarely change
SHELL ["/bin/bash", "-c"]
RUN apt update && apt install -yq curl git build-essential;
# install brew
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.bashrc 
# add brew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/opt:${PATH}"
# we don't need to autoupdate brew when we are running immedietly after install
ENV HOMEBREW_NO_AUTO_UPDATE=1 
RUN brew install watchman;
RUN brew install mkcert;
# install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash;

