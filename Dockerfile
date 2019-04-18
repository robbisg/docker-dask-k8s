FROM daskdev/dask

RUN apt-get update && apt-get install -y --no-install-recommends \
    make \
    automake \
    gcc \
    swig \
    python-tk \
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
#RUN source activate neuropy
RUN pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
#COPY prepare.sh /usr/bin/prepare.sh
#RUN chmod +x /usr/bin/prepare.sh

#RUN mkdir /opt/app

ENTRYPOINT ["/usr/local/bin/dumb-init", "/usr/bin/prepare.sh"]
