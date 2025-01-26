#!/bin/bash

echo "Installing dependencies for Whisper WebUI..."
rm -rf ./venv && mkdir ./venv
echo "Installing Miniconda..."
curl https://repo.anaconda.com/miniconda/Miniconda3-py310_24.7.1-0-Linux-x86_64.sh -o ./venv/miniconda.sh
bash ./venv/miniconda.sh -b -u -p ./venv
rm ./venv/miniconda.sh

echo "Creating virtual environment..."
source ./venv/bin/activate

modify_requirements() {
  local cuda_version=$1
  if [[ -z "$cuda_version" || $(echo "$cuda_version < 12.1" | bc) -eq 1 || $(echo "$cuda_version >= 13.0" | bc) -eq 1 ]]; then
    sed -i 's|^\(--extra-index-url.*\)|# \1|' requirements.txt
  elif [[ $(echo "$cuda_version >= 12.1" | bc) -eq 1 && $(echo "$cuda_version < 12.4" | bc) -eq 1 ]]; then
    sed -i 's|--extra-index-url.*|--extra-index-url https://download.pytorch.org/whl/cu121|' requirements.txt
  fi
}

cuda_version=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader | cut -d. -f1,2 2>/dev/null)
if [[ -z "$cuda_version" ]]; then
  echo "CUDA version not detected. Defaulting to no CUDA support."
else
  echo "Detected CUDA version: $cuda_version"
fi
echo "Modifying requirements.txt based on CUDA version..."
modify_requirements "$cuda_version"

echo "Installing dependencies..."
pip install -r requirements.txt