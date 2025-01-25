#!/bin/bash

args=("$@")
set --
source venv/bin/activate
python app.py "${args[@]}"
echo "launching the app"