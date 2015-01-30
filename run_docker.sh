set -e
docker build -t rdhyee/ipython-spark .
PORT=${1:-8888}
PORT2=${2:-4040}
DATA_DIR=${3:-/Users/raymondyee/D/Data/flickrdedupe}
docker run -d -v `pwd`:/notebooks -p $PORT:8888  -p $PORT2:4040  -v $DATA_DIR:/data -e "PASSWORD=$IPN_PW_DEFAULT" rdhyee/ipython-spark
