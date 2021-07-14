# [Choice] Python version: 3, 3.9, 3.8, 3.7, 3.6
ARG VARIANT="3.9"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}


RUN sudo apt update -y
RUN pip install rope
RUN pip install pylint
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash 
RUN sudo apt-get install -y nodejs

ENV WORK_DIR /workspace/devcontainer
RUN rm -rf ${WORK_DIR} && mkdir -p ${WORK_DIR}
RUN npm config set unsafe-perm true
RUN npm install -g nodemon

COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
   && rm -rf /tmp/pip-tmp