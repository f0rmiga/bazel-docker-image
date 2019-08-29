FROM opensuse/leap:15.1 AS installer
RUN zypper --non-interactive install \
      curl \
      java-11-openjdk \
      java-11-openjdk-devel \
      unzip \
      which \
      && zypper clean
ARG version
RUN curl -L https://github.com/bazelbuild/bazel/releases/download/${version}/bazel-${version}-installer-linux-x86_64.sh -o /tmp/bazel.installer
RUN bash /tmp/bazel.installer

# ==========================================================
FROM opensuse/leap:15.1
RUN zypper --non-interactive install \
      java-11-openjdk \
      java-11-openjdk-devel \
      && zypper clean
COPY --from=installer /usr/local/bin/bazel /usr/local/bin/bazel
COPY --from=installer /usr/local/bin/bazel-real /usr/local/lib/bazel-real
COPY --from=installer /usr/local/lib/bazel /usr/local/lib/bazel
