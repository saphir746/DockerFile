
FROM ubuntu:22.04

RUN apt-get update
RUN apt-get --yes upgrade
RUN apt-get install --yes apt-utils

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN apt-get install --yes tzdata

RUN apt-get install --yes less

RUN apt-get -y install r-base \
	   wget \
	   r-base-dev \
	   r-recommended \
           littler \
           r-cran-littler \
           libxml2-dev \
           libxt-dev \
           libssl-dev \
           libcurl4-openssl-dev
           
RUN    apt-get -y install gdebi-core
RUN    wget https://download1.rstudio.org/desktop/jammy/amd64/rstudio-2022.07.1-554-amd64.deb
RUN    gdebi rstudio-2022.07.1-554-amd64.deb

RUN     rm *amd64.deb && \
        rm -rf /var/lib/apt/lists/*

RUN apt install libnss3 \
            libasound2
            
#### update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean
        
##

RUN   R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install(ask = F)" && R -e " BiocManager::install('ComplexHeatmap', ask = F)"
##
##RUN   R -e "install.packages('ggVennDiagram', repos='http://cran.rstudio.com/')"
##RUN   R -e "install.packages(c('ggplot2','DT','tidyr'), repos='http://cran.rstudio.com/')"
##RUN   R -e "install.packages('rmarkdown', repos='http://cran.rstudio.com/')"
##RUN   R -e "install.packages('knitr', repos='http://cran.rstudio.com/')"
RUN   R -e "install.packages('tidyverse')"
RUN   R -e "install.packages('ggpubr')"
RUN   R -e "install.packages('circlize')"
RUN   R -e "install.packages('ggrepel')"
RUN   R -e "install.packages('pheatmap')"
RUN   R -e "install.packages('data.table')"
RUN   R -e "install.packages('stringr')"

RUN    apt-get clean \
    && apt-get purge

## cleanup of files from setup

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


