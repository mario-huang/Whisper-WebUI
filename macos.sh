#!/bin/bash

rm -rf ./venv && mkdir ./venv
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ./venv/miniconda.sh
bash ./venv/miniconda.sh -b -u -p ./venv
rm ./venv/miniconda.sh

source ./venv/bin/activate

pip install -r requirements.txt