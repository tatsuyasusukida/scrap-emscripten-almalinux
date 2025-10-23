FROM almalinux:latest

# 必要なパッケージのインストール
RUN dnf update -y && \
	dnf install -y git libatomic jq \
		make gcc gcc-c++ ncurses* libncurses* libpng* kernel-devel && \
	dnf clean all

# 作業ディレクトリの設定
WORKDIR /root

# emsdkのクローン
RUN git clone https://github.com/emscripten-core/emsdk.git

# emsdkディレクトリに移動
WORKDIR /root/emsdk

# 最新版のインストールとアクティベート
RUN ./emsdk install latest && \
	./emsdk activate latest

# 環境変数の設定
# Dockerfileでは各RUNコマンドが独立しているため、ENVで永続的に設定
ENV EMSDK=/root/emsdk \
    EMSDK_NODE=/root/emsdk/node/22.16.0_64bit/bin/node \
    PATH=/root/emsdk:/root/emsdk/upstream/emscripten:/root/emsdk/node/22.16.0_64bit/bin:${PATH}

# emsdk_env.shを.bashrcに追加（インタラクティブシェル用）
# RUN echo 'source "/root/emsdk/emsdk_env.sh"' >> /root/.bashrc

# 作業ディレクトリを設定
WORKDIR /workspace

# デフォルトコマンド
CMD ["/bin/bash"]