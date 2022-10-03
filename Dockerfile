FROM archlinux:base-devel

ADD mirrorlist /etc/pacman.d/mirrorlist
RUN yes | pacman -Syu
RUN yes | pacman -S git zsh
RUN mkdir -p /root/.config
VOLUME ["/root/.config","/root/repos","/root/.vscode-server/extensions", "/root/go/bin", "/root/.ssh"]
# end

# oh-my-zsh
RUN yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions &&\
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ADD .zshrc /root/.zshrc
ENV SHELL /bin/zsh
#end

# basic tools
RUN yes | pacman -S curl tree vim wget
# end

# Install Go
RUN yes | pacman -Syy; yes | pacman -S go
ENV GOPATH /root/go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
ENV GOROOT /usr/lib/go
RUN go env -w GO111MODULE=on &&\
    go env -w GOPROXY=https://goproxy.cn,direct &&\
		go install github.com/silenceper/gowatch@latest
# end

# nvm
ENV NVM_DIR /root/.nvm
ADD nvm-0.39.1 /root/.nvm/
RUN sh ${NVM_DIR}/nvm.sh &&\
	echo '' >> /root/.zshrc &&\
	echo 'export NVM_DIR="$HOME/.nvm"' >> /root/.zshrc &&\
	echo '[ -s "${NVM_DIR}/nvm.sh" ] && { source "${NVM_DIR}/nvm.sh" }' >> /root/.zshrc &&\
	echo '[ -s "${NVM_DIR}/bash_completion" ] && { source "${NVM_DIR}/bash_completion" } ' >> /root/.zshrc
# end

# nodejs and tools
RUN bash -c 'source $HOME/.nvm/nvm.sh   && \
	nvm install --lts                   && \
    npm install -g pnpm yarn http-server typescript yrm'
# end

# tools
RUN yes | pacman -S fzf ranger neofetch htop openssh net-tools exa the_silver_searcher fd rsync &&\
		ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key
# end

# dotfiles
RUN echo "export TZ='Asia/Shanghai'" >> /root/.zshrc; \
	echo "alias ra=ranger" >> /root/.zshrc;
# end
