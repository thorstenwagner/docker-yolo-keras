ARG cuda_version=8.0
ARG cudnn_version=6
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    apt-get update && \
    apt-get install -y wget git libhdf5-dev g++ graphviz openmpi-bin && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.2.12-Linux-x86_64.sh && \
    /bin/bash /Miniconda2-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda2-4.2.12-Linux-x86_64.sh

ENV NB_USER keras
ENV NB_UID 1000

#RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
#    mkdir -p $CONDA_DIR && \
#    chown keras $CONDA_DIR -R && \
#    mkdir -p /src && \
#    chown keras /src
    
#USER keras

# Python ---
ARG python_version=2.7

RUN conda install -y python=${python_version} && \
    pip install --upgrade pip && \
    pip install tensorflow-gpu && \
    pip install https://cntk.ai/PythonWheel/GPU/cntk-2.3.1-cp27-cp27mu-linux_x86_64.whl && \
    conda install Pillow scikit-learn notebook pandas matplotlib mkl nose pyyaml six h5py && \
    conda install theano pygpu bcolz && \
    pip install sklearn_pandas && \
    git clone git://github.com/keras-team/keras.git /src && pip install -e /src[tests] && \
    pip install git+git://github.com/keras-team/keras.git && \
    conda clean -yt

#ADD theanorc /home/keras/.theanorc

ENV PYTHONPATH='/src/:$PYTHONPATH'

# Yolo specific things
RUN pip install imgaug
#RUN git clone https://github.com/experiencor/basic-yolo-keras
