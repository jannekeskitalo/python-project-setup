#!/bin/bash

set -e

# Requires pyenv to be installed prior

# Check if the correct number of arguments is given
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <python_version> <project_dir>"
    exit 1
fi

# Assign the arguments to variables
PYTHON_VERSION=$1
PROJECT_DIR=$2

eval "$(pyenv init -)"

# Activate shell with correct python version
pyenv shell $PYTHON_VERSION

# Check correct python version is used
python --version

# Install poetry for this python version
pip install poetry

# Create the project directory and boilerplate
poetry new $PROJECT_DIR

# Go to the created project dir
cd $PROJECT_DIR

# Set local python version
pyenv local $PYTHON_VERSION

# Install virtual env
poetry install

# When poetry env is active in the terminal, you can install packages
poetry add art

# Run some code
poetry run python -c "from art import text2art; print(text2art('It works'))"
