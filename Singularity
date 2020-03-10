Bootstrap: docker
From: debian:10

%setup
    # Nothing to be done here

%files
    # No files to copy for now

%environment
    #

%post
    apt-get update

    # Python essentials:
    apt-get install -y python3.7 python3.7-dev python3.7-venv python3-pip
    pip3 install pipenv

    # SUMO:
    export SUMO_VERSION=v1_1_0
    export SUMO_HOME=/opt/sumo/$SUMO_VERSION
    echo 'export SUMO_VERSION=v1_1_0' >> $SINGULARITY_ENVIRONMENT
    echo 'export SUMO_HOME=/opt/sumo/$SUMO_VERSION' >> $SINGULARITY_ENVIRONMENT
    echo 'export PATH=$SUMO_HOME/bin:$PATH' >> $SINGULARITY_ENVIRONMENT
    apt-get install -y \
        build-essential \
        wget \
        vim \
        clang \
        g++ \
        python \
        xvfb \
        unzip \
        desktop-file-utils \
        autoconf \
        automake \
        libtool \
        libproj-dev \
        libfox-1.6-dev \
        libgdal-dev \
        libxerces-c-dev \
        libgl2ps-dev \
        swig \
        git \
        cmake
    mkdir -p /opt/sumo
    cd /opt/sumo
    git clone \
        --recursive \
        --depth 1 --branch $SUMO_VERSION \
        https://github.com/eclipse/sumo \
        $SUMO_VERSION
    cd $SUMO_HOME
    mkdir -p build/cmake-build
    cd build/cmake-build
    cmake ../..
    make -j$(nproc)

    # TODO: OMNeT++, Veins?
    
    # Cleanup
    apt-get clean
    rm -rf /var/lib/apt

%runscript
    # Executed if container is run as a binary.
    if [ $# -ne 0 ]; then
        exec "$@"
    else
        exec bash --norc --noprofile
    fi

%startscript
    # Executed if started like so:
    #  singularity instance start vce.sif my-vce-isntance
    echo "Startscript"

%test
    # No tests for now

%labels
    Author ccs-labs.org
    Version v0.0.1

%help
    This container contains SUMO and a compatible Python version for running the Virtual Cycling Environment (VCE).
    For more information on the VCE, visit https://www.ccs-labs.org/software/vce/.
