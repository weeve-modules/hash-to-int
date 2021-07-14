#! /bin/bash

WORK_DIR=/workspace/devcontainer


cp ${WORK_DIR}/.devcontainer/package.json ${WORK_DIR}/package.json
export FLASK_ENV=development
bash