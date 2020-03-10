Bootstrap: docker
From: debian:10

%setup
    # Nothing to be done here

%files
    # Texlive installation profile:
    # You can generate your own by getting the Texlive `install-tl` script
    # as detailed below in %post, running it without arguments to get the
    # interactive mode, make your changes (I selected the installation scheme
    # "scheme-basic"), then choose the option to just save the profile to `texlive.profile`.
    # IMPORTANT: Don't forget to edit the file to make the paths match the
    # expectations in %post below, and to make them work with Singularity!
    singularity_texlive.profile /tmp/texlive.profile

%environment
    #

%post
    apt-get update

    # LaTeX via Texlive
    apt-get install --no-install-recommends -y \
        perl \
        curl \
        wget \
        poppler-utils
    curl -o /tmp/install-tl-unx.tar.gz http://ftp.acc.umu.se/mirror/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
    cd /tmp/
    tar xzf install-tl-unx.tar.gz
    rm install-tl-unx.tar.gz
    bash -c "cd /tmp/install-tl-* && ./install-tl -profile /tmp/texlive.profile -no-verify-downloads -persistent-downloads"
    echo 'export PATH=/usr/local/texlive/bin/x86_64-linux:$PATH' >> $SINGULARITY_ENVIRONMENT
    echo 'export MANPATH=/usr/local/texlive/texmf-dist/doc/man:$MANPATH' >> $SINGULARITY_ENVIRONMENT
    echo 'export INFOPATH=/usr/local/texlive/texmf-dist/doc/info:$INFOPATH' >> $SINGULARITY_ENVIRONMENT

    export PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
    # Install individual additional packages (saves a lot of diskspace compared to using the next 'level' of `install-tl`):
    tlmgr install csquotes
    tlmgr install ucs  # for utf8x.def, expected by Matplotlib
    tlmgr install pgf xcolor

    # Python essentials:
    apt-get install --no-install-recommends -y \
        python3.7 python3.7-dev python3.7-venv python3-pip
    pip3 install setuptools
    pip3 install pipenv

    # SUMO:
    export SUMO_VERSION=v1_1_0
    export SUMO_HOME=/opt/sumo/$SUMO_VERSION
    echo 'export SUMO_VERSION=v1_1_0' >> $SINGULARITY_ENVIRONMENT
    echo 'export SUMO_HOME=/opt/sumo/$SUMO_VERSION' >> $SINGULARITY_ENVIRONMENT
    echo 'export PATH=$SUMO_HOME/bin:$PATH' >> $SINGULARITY_ENVIRONMENT
    apt-get install --no-install-recommends -y \
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
