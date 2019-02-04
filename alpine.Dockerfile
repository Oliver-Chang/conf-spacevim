FROM alpine:latest
MAINTAINER Oliver Chang <oliverchangnt@gmail.com>

# terminal color
ENV TERM screen-256color


RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk --update add --no-cache make zsh fontconfig mkfontdir mkfontscale \
            go \
            python2 python2-dev py2-pip python3 python3-dev libc-dev \
            nodejs npm curl \
            clang \
            neovim git

# for neo4j 
RUN apk --update add --no-cache pkgconf

ENV HOME "/home/spacevim"
RUN adduser --shell /bin/zsh -h $HOME spacevim -D

USER spacevim

WORKDIR $HOME

ENV GOPATH="${HOME}/go"
ENV PATH="${HOME}/.local/bin:${PATH}"
ENV PATH="${GOPATH}/bin:${PATH}"

RUN pip3 install --user neovim python-language-server typing
RUN pip2 install --user neovim 
RUN go get -u github.com/sourcegraph/go-langserver

# RUN echo "create config file"
RUN curl -sLf https://spacevim.org/install.sh | sh

# RUN echo "create config file"
RUN mkdir -p $HOME/.SpaceVim.d/

RUN wget https://raw.githubusercontent.com/Oliver-Chang/conf-spacevim/master/init.toml -O $HOME/.SpaceVim.d/init.toml
RUN nvim --headless +'call dein#install()' +qall

ENTRYPOINT ["nvim"]
