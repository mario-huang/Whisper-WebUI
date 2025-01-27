#!/bin/bash

rm -rf ./venv
mkdir ./venv
curl https://repo.anaconda.com/miniconda/Miniconda3-py310_24.7.1-0-MacOSX-arm64.sh -o ./venv/miniconda.sh
bash ./venv/miniconda.sh -b -u -p ./venv
rm ./venv/miniconda.sh

sed -i '' 's|^\(--extra-index-url.*\)|# \1|' requirements.txt

source ./venv/bin/activate
pip install -r requirements.txt