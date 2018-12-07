FROM centos:7.6.1810

ARG INSTALL_DIR=/root/install
WORKDIR ${INSTALL_DIR}

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib

# Install EPEL and dependencies
RUN yum install -y wget curl git && \
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum repolist && \
    yum remove -y vi* && \
    yum install -y gcc gcc-c++ make cmake automake ctags tree jq \
    python-devel python3-devel ruby-devel perl-devel perl-ExtUtils-Embed lua-devel libX11-devel libXt-devel gtk-devel gtk2-devel gtk3-devel ncurses-devel

# Install Graphviz
ARG GRAPHVIZ_VERSION=2.30.1-21
RUN wget http://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/graphviz-${GRAPHVIZ_VERSION}.el7.x86_64.rpm && \
    yum install -y graphviz-${GRAPHVIZ_VERSION}.el7.x86_64.rpm && \
    rm -f graphviz-${GRAPHVIZ_VERSION}.el7.x86_64.rpm

# Install tmux
ADD tmux.conf /root/.tmux.conf
ARG LIBEVENT_VERSION=2.1.8
ARG TMUX_VERSION=2.7
RUN wget https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz && \
    tar -zxvf libevent-${LIBEVENT_VERSION}-stable.tar.gz && \
    rm -f libevent-${LIBEVENT_VERSION}-stable.tar.gz && \
    cd libevent-${LIBEVENT_VERSION}-stable && \
    ./configure && \
    make && make install && \
    cd .. && wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz && \
    tar -zxvf tmux-${TMUX_VERSION}.tar.gz && \
    rm -f tmux-${TMUX_VERSION}.tar.gz && \
    cd tmux-${TMUX_VERSION} && \
    ./configure && \
    make && make install

# Install zsh and oh-my-zsh
ARG ZSH_VERSION=5.6.2
RUN wget https://nchc.dl.sourceforge.net/project/zsh/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz && \
    tar -xvJf zsh-${ZSH_VERSION}.tar.xz && \
    rm -f zsh-${ZSH_VERSION}.tar.xz && \
    cd zsh-${ZSH_VERSION} && \
    ./configure --with-tcsetpgrp && \
    make && make install && \
    command -v zsh | tee -a /etc/shells && \
    chsh -s "$(command -v zsh)" && \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install vim
RUN git clone https://github.com/vim/vim.git ./vim && cd ./vim && \
    ./configure --with-features=huge \
	--with-x \
	--enable-multibyte \
    	--enable-rubyinterp=yes \
    	--enable-pythoninterp=yes \
    	--enable-python3interp=yes \
    	--enable-perlinterp=yes \
    	--enable-luainterp=yes \
    	--enable-rubyinterp=yes \
    	--enable-gui=gtk2 --enable-cscope --prefix=/usr/local && \
    make && make install

# Install Vundle and Plugin
ADD vimrc /root/.vimrc
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall

# Install language
## Go
ARG GO_VERSION=1.11.2
RUN wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -zxf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm -f go${GO_VERSION}.linux-amd64.tar.gz

    # Go env
    ENV GOROOT ${INSTALL_DIR}/go
    ENV GOPATH /root/gopath
    ENV GOBIN $GOPATH/bin
    ENV PATH  $PATH:$GOROOT/bin:$GOBIN

## JavaScript and TypeScript
ARG NODE_VERSION=v8.11.3
ENV PATH $PATH:${INSTALL_DIR}/node-$NODE_VERSION-linux-x64/bin
RUN wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz && \
    tar -zxf node-${NODE_VERSION}-linux-x64.tar.gz && \
    rm -f node-${NODE_VERSION}-linux-x64.tar.gz && \
    npm install -g typescript

## Rust
ARG RUST_VERSION=1.30.1
RUN wget https://static.rust-lang.org/dist/rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz && \
    tar -zxf rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz && \
	rm -f rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz && \
	cd rust-${RUST_VERSION}-x86_64-unknown-linux-gnu && \
	./install.sh

# Generate ycm_extra_conf.py
RUN cd /root/.vim/bundle/YouCompleteMe && \
    git submodule update --init --recursive && \
    python install.py --clang-completer \
	--go-completer \
	--racer-completer && \
	#--js-completer && \
    cp third_party/ycmd/examples/.ycm_extra_conf.py /root

# Install tools
##shellcheck
RUN wget https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz && \
    tar -xvJf shellcheck-stable.linux.x86_64.tar.xz && \
    rm -f shellcheck-stable.linux.x86_64.tar.xz && \
    cp shellcheck-stable/shellcheck /usr/local/bin

##yamllint
RUN yum install -y python-pip && \
    pip install --upgrade pip && \
    pip install yamllint

#ADD colors /root/.vim/colors
ADD README /root/README

# Add profile
ARG SHRCFILE=/root/.zshrc
RUN echo '############### env ###############' >> ${SHRCFILE} && \
    echo 'set -o vi' >> ${SHRCFILE} && \
    echo 'alias vi="vim"' >> ${SHRCFILE} && \
    echo 'alias tmux="tmux -2"' >> ${SHRCFILE} && \
    echo '############### env ###############' >> ${SHRCFILE} && \
    echo '' >> ${SHRCFILE}

WORKDIR /root

# TODO update
#ADD vimrc_new /root/.vimrc

CMD ["zsh"]

