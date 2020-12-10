FROM quay.io/giantswarm/alpine:3.12.1 AS downloader

WORKDIR /tmp/hyperkube

COPY go.mod go.mod

RUN KUBERNETES_VERSION=$(cat go.mod | grep k8s.io/kubectl | cut -d ' ' -f 3 | sed 's/v0./v1./') && \
    wget -t 5 https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubelet && \
    wget -t 5 https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl && \
    chmod +x /tmp/hyperkube/kubelet /tmp/hyperkube/kubectl

FROM scratch

COPY --from=downloader /tmp/hyperkube/kubelet /kubelet
COPY --from=downloader /tmp/hyperkube/kubectl /kubectl
