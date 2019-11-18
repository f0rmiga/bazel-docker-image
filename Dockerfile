FROM opensuse/leap:15.1 AS baselayer
RUN zypper --non-interactive install \
      curl \
      gcc \
      git \
      gzip \
      java-11-openjdk \
      java-11-openjdk-devel \
      python \
      python3 \
      pip \
      sudo \
      tar \
      unzip \
      which \
      && zypper clean
RUN groupadd --gid 115 runner \
      && useradd --system --create-home --uid 1001 --gid runner runner
RUN echo "%runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/runner
USER runner

# ==========================================================
FROM baselayer AS installer
ARG version
RUN curl -L https://github.com/bazelbuild/bazel/releases/download/${version}/bazel-${version}-installer-linux-x86_64.sh -o /tmp/bazel.installer
RUN bash /tmp/bazel.installer --user

# ==========================================================
FROM baselayer
COPY --from=installer /home/runner /home/runner
RUN sudo ln -s /home/runner/bin/bazel /usr/local/bin/bazel
