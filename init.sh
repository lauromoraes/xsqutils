#!/bin/bash
VIRTUALENV=`which virtualenv-2.7`
if [ "$VIRTUALENV" == "" ]; then
    VIRTUALENV=`which virtualenv-2.6`
fi
if [ "$VIRTUALENV" == "" ]; then
    VIRTUALENV=`which virtualenv`
fi
if [ "$VIRTUALENV" == "" ]; then
    echo "Missing virtualenv!"
    exit 1
fi

if [ ! -e env ]; then 
    echo "Initializing virtualenv folder (env)"
    $VIRTUALENV --no-site-packages env
fi

. env/bin/activate

pip install numpy==1.9.2
pip install cython==0.22
pip install numexpr==2.4.4

pip install --upgrade --force-reinstall numpy==1.9.2

# Set environment variables to help PyTables find HDF5
HDF5_DIR=/usr/lib/x86_64-linux-gnu/hdf5/serial
CFLAGS="-I/usr/include/hdf5/serial"
LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/serial"

# Install PyTables with the correct HDF5 paths
pip install --no-cache-dir tables==2.3.1 --global-option=build_ext
