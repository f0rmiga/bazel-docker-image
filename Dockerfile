FROM opensuse/leap:15.1 AS baselayer
RUN zypper --non-interactive install \
      curl \
      gcc \
      gcc-c++ \
      git \
      gzip \
      iproute2 \
      iptables \
      java-11-openjdk \
      java-11-openjdk-devel \
      python \
      python3 \
      python2-pip \
      python3-pip \
      ruby \
      sudo \
      tar \
      unzip \
      which \
      && zypper clean

# ==========================================================
FROM baselayer
ARG version
RUN curl -L https://github.com/bazelbuild/bazel/releases/download/${version}/bazel-${version}-installer-linux-x86_64.sh -o /tmp/bazel.installer
RUN bash /tmp/bazel.installer
