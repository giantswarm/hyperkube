FROM quay.io/giantswarm/alpine:3.12.1 AS downloader

WORKDIR /tmp/hyperkube

ARG KUBERNETES_VERSION

RUN wget https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubelet && \
    wget https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl

FROM scratch

COPY --from=downloader /tmp/hyperkube/kubelet /kubelet
COPY --from=downloader /tmp/hyperkube/kubectl /kubectl
