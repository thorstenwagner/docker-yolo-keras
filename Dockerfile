ARG cuda_version=8.0
ARG cudnn_version=6
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN apt-get update
RUN apt-get install -y python2.7 wget git nano
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.2.12-Linux-x86_64.sh
RUN bash Miniconda2-4.2.12-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda2-4.2.12-Linux-x86_64.sh
RUN pip install --upgrade pip
RUN pip install tensorflow-gpu
RUN pip install keras
RUN pip install mrcfile
RUN apt-get install -y libopencv-dev python-opencv vim imagemagick nano
RUN pip install imgaug
RUN conda install -y opencv
RUN conda install -y h5py
RUN conda install -y tqdm
RUN git clone https://www.github.com/keras-team/keras-contrib.git
RUN cd keras-contrib
RUN python setup.py install
RUN mkdir /root/logs/
