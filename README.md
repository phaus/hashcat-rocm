# Hashcat ROCM

[hashcat](https://hashcat.net/hashcat/) setup based on the [Radeon Open Compute Platform](https://www.amd.com/en/technologies/open-compute), using [opencl](https://www.khronos.org/opencl/).

## BUILD

    docker build -t phaus/hashcat-rocm .

## RUN

    cd /tmp && wget https://hashcat.net/misc/example_hashes/hashcat.hccapx
    docker run \
        --device=/dev/kfd \
        --device=/dev/dri \
        -v /tmp:/tmp \
        phaus/hashcat-rocm -m 2500 /tmp/hashcat.hccapx /installs/apps/wordlists/rockyou.txt
