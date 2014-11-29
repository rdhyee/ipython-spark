set -e
docker build -t rdhyee/ipython-spark .
PORT=${1:-8888}
DATA_DIR=${2:-/Users/raymondyee/D/Data/flickrdedupe}
docker run -d -v `pwd`:/notebooks -p $PORT:8888 -v $DATA_DIR:/data -e "PASSWORD=$IPN_PW_DEFAULT" rdhyee/ipython-spark
#docker run -it  -v `pwd`:/notebooks -p $PORT:8888 -v $DATA_DIR:/data -e "PASSWORD=$IPN_PW_DEFAULT" rdhyee/ipython-spark bash
