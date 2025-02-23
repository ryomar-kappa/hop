FROM --platform=linux/amd64 ubuntu:20.04

# tzdata install 時に timezone 聞かれないようにするためのおまじない
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    unzip \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    language-pack-ja \
    android-sdk \
    openjdk-17-jdk \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    update-locale LANG=ja_JP.UTF-8
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:${PATH}"

# Flutter セットアップ実行
RUN flutter doctor --android-licenses || true
RUN flutter doctor

# Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip && \
    unzip commandlinetools-linux-11076708_latest.zip && \
    mkdir -p /usr/lib/android-sdk/cmdline-tools/latest && \
    mv /cmdline-tools/* /usr/lib/android-sdk/cmdline-tools/latest/
ENV JAVA_HOME=/usr
ENV PATH=$JAVA_HOME/bin:$PATH
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools/bin

# 下記は android-sdk がデフォルトで入れるのでクリーンしてからインストール.
RUN rm -rf /usr/lib/android-sdk/build-tools /usr/lib/android-sdk/platforms
RUN yes | sdkmanager "platforms;android-34" "build-tools;33.0.1"
RUN yes | flutter doctor --android-licenses
CMD ["flutter", "--version"]