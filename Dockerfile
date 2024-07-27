FROM ubuntu:16.04

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y python libgmp10 python-pip git gcc autoconf automake libcap-dev pkg-config libssl-dev vim ledger && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install a specific version of pip that is compatible with Python 2
RUN pip install pip==20.3.4

# Install required Python packages
RUN pip install web.py boto3 pynacl python-jose ofxhome lxml beautifulsoup4 'keyring==18.0.1'

# Install ofxparse
RUN pip install ofxparse==0.19

# Clone and install ofxclient
RUN git clone https://github.com/captin411/ofxclient.git && \
    cd ofxclient && python setup.py install && cd .. && rm -rf ofxclient

# Add application files
ADD . /root/ledgereditor/
WORKDIR /root/ledgereditor

# Expose port
EXPOSE 8888

# Set entrypoint
ENTRYPOINT ["/usr/bin/python", "serve_ledger.py"]
