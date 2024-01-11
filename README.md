# How to setup a python project

Setting up a python project for development and delivery can be quite complicated. I have an established method which I'm going to show here. I’m developing on M2 MacBook and deploying to amd64/arm64 linux hosts.

## Install pyenv

My method requires pyenv and poetry -tools. In my experience these tools don't work very well together in the setup phase and
all the following steps are the result of a meticulous process of trial and error. I actually have multiple equally complicated ways
to reach the end result, but this is what I use at the moment.

```bash
# Install pyenv
brew install pyenv
```

**pyenv** is used to manage python versions on the development machine. It allows installing many python binaries without messing up the OS python.

Rest of this doc explains how the setup is done. You can skip it and just use the provided script.

```bash
# Usage: ./setup.sh <python_version> <project_dir>
./setup.sh 3.11.4 my-app
```

## Setup project

Project setup steps explained.

### First about poetry

**poetry** is used to manage project's python package dependencies. It creates a virtual python env which is isolated for the project
and contains all the installed dependencies. You can delete the env and recreate easily without affecting other projects or OS python.
Poetry is also used to build the project for delivery.

In this process poetry is installed per each pyenv python -version. This is because poetry seems to default
using the python version it is running itself on and then applying that to the project virtual env. We workaround it by
having poetry package installed separately for each python version.

Poetry can also be installed on system level using brew, but then the setup requires extra steps to force the virtual env python version.

Lets create a new project using c-python 3.11.4

```bash
# Check installed python versions
pyenv versions

# If desired version is not installed, list available
pyenv install --list

# Lets install the latest stable cpython
pyenv install 3.11.4
```

Project setup

```bash
# Go to the dir where you have all your project folders

# Activate shell with correct python version
pyenv shell 3.11.4
# Check correct python version is used
python --version
# Install poetry for this python version
pip install poetry
# Create the project directory and boilerplate
poetry new my-app
# Go to the created project dir
cd my-app
# Set local python version
pyenv local 3.11.4
# Install virtual env
poetry install
# Activate env to run the project in terminal
poetry shell
# Install packages
poetry add art
# Run some code
python -c "from art import text2art; print(text2art('It works'))"

```

## Setup in VS Code

Open the my-app folder in new VS Code -window. Open new Terminal in VS Code.
You should see that the poetry virtual env was automatically activated. If not, press Shift+Cmd+p to open command palette. There type "python" and select "Python: Select Interpreter". You might need to refresh the list, but you should see an env starting with the name of your project dir. Select that, terminate your terminal window (trash bin icon) and start a new terminal window in VS Code.

## Done

Now you can add source files to your new package under my_app -directory.

## Disclaimer

These steps work in OSX Sonoma 14.2.1 as of June 2024 with pyenv installed from brew.
