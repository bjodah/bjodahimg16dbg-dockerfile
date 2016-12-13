#!/bin/bash -ux
#
# Usage:
#
#   $ ./download-install-sundials.sh $HOME/.local
#
PREFIX=$1
SUNDIALS_FNAME="sundials-2.7.0.tar.gz"
SUNDIALS_MD5="c304631b9bc82877d7b0e9f4d4fd94d3"
SUNDIALS_URLS=(\
"http://pkgs.fedoraproject.org/repo/pkgs/sundials/${SUNDIALS_FNAME}/${SUNDIALS_MD5}/${SUNDIALS_FNAME}" \
"http://computation.llnl.gov/projects/sundials/download/${SUNDIALS_FNAME}" \
)
TIMEOUT=300
for URL in "${SUNDIALS_URLS[@]}"; do
    if echo $SUNDIALS_MD5 $SUNDIALS_FNAME | md5sum -c --; then
        echo "Found ${SUNDIALS_FNAME} with matching checksum, using this file."
    else
        echo "Downloading ${URL}..."
        timeout $TIMEOUT wget --quiet --tries=2 --timeout=$TIMEOUT $URL -O $SUNDIALS_FNAME || continue
    fi
    if echo $SUNDIALS_MD5 $SUNDIALS_FNAME | md5sum -c --; then
        tar xzf $SUNDIALS_FNAME
        mkdir build
        cd build/
        cmake \
            -DCMAKE_PREFIX_PATH=$PREFIX \
            -DCMAKE_INSTALL_PREFIX=$PREFIX \
            -DCMAKE_BUILD_TYPE=Debug \
            -DBUILD_SHARED_LIBS=1 \
            -DBUILD_STATIC_LIBS=0 \
            -DEXAMPLES_ENABLE=1 \
            -DEXAMPLES_INSTALL=0 \
            -DOPENMP_ENABLE=0 \
            -DLAPACK_ENABLE=1 \
            -DLAPACK_LIBRARIES=lapack \
            ../sundials-*/

        cmake --build .
        cmake --build . --target install
        
        exit 0
    fi
done
exit 1
