#!/bin/bash
set -e

source venv/bin/activate
python app.py "$@"

echo "launching the app"