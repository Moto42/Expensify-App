# Note: NVM must be called via `bash -i -c 'nvm ...'`.
# Without the -i flag, it is running 'noninteractivly' and ignores the commands 
# in ~/.profile that load NVM and ready it for use.

FROM ubuntu:24.04 AS base_dependencies
# Stage for the basic dependencies that will rarely change
SHELL ["/bin/bash", "-c"]
# need curl for some installs, nvm req git, brew req build-essential.
RUN apt update && apt install -yq curl git build-essential libnss3-tools;
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

FROM base_dependencies AS node_installed
# Isoalte nvm install to its own stage. Node version will probably change more
# often than the items in base_dependencies.
# Only file this stage requires.
COPY .nvmrc /tempexpensify/.nvmrc
WORKDIR /tempexpensify
# install && cleanup
RUN bash -i -c 'nvm install' && rm -rf tempexpensify;

# From here we need to npm install and npm run setup-https.
# As the node_modules folder dosent' belong in the image,
# this will be done when the container is created.
# see devcontainer.json > onCreateCommand for more.
