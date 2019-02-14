FROM daskdev/dask

RUN apt-get update && apt-get install -y --no-install-recommends \
    make \
    automake \
    gcc \
    build-essential \
    g++ \
    cpp \
    libc6-dev \
    man-db \
    autoconf \
    pkg-config

ADD environment.yaml /tmp/environment.yaml
RUN conda env create -f /tmp/environment.yaml

RUN conda clean -tipsy
RUN echo "source activate neuropy" > ~/.bashrc
ENV PATH /opt/conda/envs/neuropy/bin:$PATH
#COPY prepare.sh /usr/bin/prepare.sh
#RUN chmod +x /usr/bin/prepare.sh

#RUN mkdir /opt/app

ENTRYPOINT ["/usr/local/bin/dumb-init", "/usr/bin/prepare.sh"]
