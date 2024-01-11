FROM ubuntu
RUN apt update
RUN apt install -y wget bzip2
WORKDIR /opt
RUN wget -O Mambaforge.sh  "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh" -O Mambaforge.sh
RUN bash Mambaforge.sh -b -p /opt/miniconda
RUN rm  Mambaforge.sh
    #add channels



# install dependencies
# RUN apt-get --yes install default-jre
ENV PATH="/opt/miniconda/envs/py2715/bin:/opt/miniconda/bin:$PATH"
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

RUN mamba install -c bioconda trimmomatic vsearch bedtools bowtie2 samtools diamond -y
RUN mamba create -n  py2715 python=2.7.15
WORKDIR /workspace
COPY . /workspace
RUN pip install .
RUN rm -rf *

#  mamba init bash