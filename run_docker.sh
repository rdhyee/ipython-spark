set -e
docker build -t rdhyee/ipython-spark .
PORT=${1:-8888}
docker run -d -v `pwd`:/notebooks -p $PORT:8888 -e "PASSWORD=$IPN_PW_DEFAULT" rdhyee/ipython-spark
