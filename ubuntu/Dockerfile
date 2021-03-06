FROM buildpack-deps:bionic-scm
MAINTAINER Oliver Chang <oliverchangnt@gmail.com>

# terminal color
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive


# update 123
RUN apt-get update -y

# install ppa tool
RUN apt-get install -y software-properties-common
            
# add neovim ppa
RUN add-apt-repository ppa:neovim-ppa/stable -y -u

RUN apt-get install -y neovim \
            python3 \
            python3-pip \
            golang \
            neovim \
            cscope \
            ctags \
            gosu

RUN apt-get clean all    


ENV HOME "/home/oliver"

RUN groupdel users && groupadd -r oliver
RUN useradd --create-home --home-dir $HOME -r -g oliver oliver -u 1000

USER oliver


WORKDIR $HOME

ENV GOPATH="${HOME}/go"
ENV PATH="$HOME/.local/bin:$PATH"
ENV PATH="$HOME/go/bin:$PATH"

RUN pip3 install --user neovim python-language-server
RUN go get -u github.com/sourcegraph/go-langserver

RUN curl -sLf https://spacevim.org/install.sh | bash

RUN mkdir -p $HOME/.SpaceVim.d/
RUN mkdir -p $HOME/Workspace
RUN curl https://raw.githubusercontent.com/Oliver-Chang/conf-spacevim/master/init.toml -o $HOME/.SpaceVim.d/init.toml  
RUN nvim --headless +'call dein#install()' +qall
RUN nvim --headless +'GoInstallBinaries' +qall

USER root
RUN apt-get install -y libssl1.0.0 pkg-config libssl-dev
RUN wget https://github.com/neo4j-drivers/seabolt/releases/download/v1.7.0/seabolt-1.7.0-Linux-Ubuntu-Xenial.deb
RUN apt-get install -y ./seabolt-1.7.0-Linux-Ubuntu-Xenial.deb
RUN apt-get install -y golang-glide 

User oliver
COPY entrypoint.sh $HOME/entrypoint.sh
WORKDIR $HOME/Workspace
ENV WORKSPACE=$HOME/Workspace
ENTRYPOINT ["../entrypoint.sh"]
