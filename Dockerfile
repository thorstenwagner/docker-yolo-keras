ARG cuda_version=8.0
ARG cudnn_version=6
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN apt-get update
RUN apt-get install -y python2.7 wget git nano
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.4.10-Linux-x86_64.sh
RUN bash Miniconda2-4.4.10-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda2-4.4.10-Linux-x86_64.sh
RUN pip install --upgrade pip
RUN pip install -I tensorflow-gpu==1.4.1
RUN pip install -U keras
RUN pip install -U mrcfile
RUN pip install jupyter
RUN pip install -U scikit-learn
RUN python -mpip install -U matplotlib
RUN apt-get install -y libopencv-dev python-opencv vim imagemagick nano freeglut3-dev
RUN pip install imgaug
RUN conda install -y opencv
RUN conda install -y h5py
RUN conda install -y tqdm
RUN pip install git+https://www.github.com/keras-team/keras-contrib.git
RUN mkdir /root/logs/


#INSTALL EMAN2
RUN conda install -y cmake=3.9 -c defaults
RUN conda install -y eman-deps=9 -c cryoem -c defaults -c conda-forge
RUN pip install matplotlib==2.0.0
RUN git clone https://github.com/cryoem/eman2.git
RUN mkdir /eman2_build
RUN echo 'cd /eman2_build && cmake ../eman2 && make && make install' > eman2build.sh
RUN bash eman2build.sh

