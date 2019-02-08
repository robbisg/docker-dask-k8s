FROM daskdev/dask

RUN conda install --yes \
    -c conda-forge \
    python-blosc \
    cytoolz \
    dask \
    nomkl \
    numpy \
    pandas \
    distributed \
    scikit-learn \
    nilearn \
    && conda clean -tipsy

#COPY prepare.sh /usr/bin/prepare.sh
#RUN chmod +x /usr/bin/prepare.sh

#RUN mkdir /opt/app

ENTRYPOINT ["/usr/local/bin/dumb-init", "/usr/bin/prepare.sh"]
