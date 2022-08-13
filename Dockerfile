FROM tiangolo/uvicorn-gunicorn:python3.8
LABEL maintainer=="Sudan Bhandari"

RUN apt-get -yq update

RUN pip install --upgrade pip


ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupadd -g ${PGID} sudan && \
    useradd -l -u ${PUID} -g sudan -m sudan && \
    usermod -p "*" sudan -s /bin/bash

USER sudan
WORKDIR /app
COPY . /app/

USER root 
RUN chown -R sudan:sudan /app/

USER sudan
RUN pip install -r /app/requirements.txt

# COPY ./requirements.txt /requirements.txt
# RUN pip install -r /dev_requirements.txt

