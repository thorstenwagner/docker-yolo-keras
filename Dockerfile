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
RUN pip install -U tensorflow-gpu
RUN pip install -U keras
RUN pip install -U mrcfile
RUN pip install -U scikit-learn
RUN python -mpip install -U matplotlib
RUN apt-get install -y libopencv-dev python-opencv vim imagemagick nano
RUN pip install imgaug
RUN conda install -y opencv
RUN conda install -y h5py
RUN conda install -y tqdm
RUN pip install git+https://www.github.com/keras-team/keras-contrib.git
RUN mkdir /root/logs/

#### SETUP SSH
# Setup ssh server
#RUN apt-get update && apt-get install -y openssh-server
#RUN mkdir /var/run/sshd
#RUN echo 'root:sshtest' | chpasswd
#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# CUDA environment is not passed by default to the SSH session. One has to export it in /etc/profile/ 
#RUN echo "export PATH=$PATH" >> /etc/profile && \
#    echo "ldconfig" >> /etc/profile

#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]
