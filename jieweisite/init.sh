DOCKER_IMAGE_VERSION="v1"
passwordcompose=$(cat BASEPHPMYSQL/compose.pwd) 
docker login ghcr.io -u secosun --password $passwordcompose

existbase=$(docker inspect --type=image  ghcr.io/secosun/jhvegebase:latest | grep -c "LastTagTime")
if [ $existbase -ne 1 ]; then 
# 拉取最新的镜像
#docker pull ghcr.io/secosun/jhbase:latest || true

# 使用最新拉取的镜像作为缓存层
docker build \
  --cache-from ghcr.io/secosun/jhvegebase:latest \
  -t ghcr.io/secosun/jhvegebase:$DOCKER_IMAGE_VERSION \
  -t ghcr.io/secosun/jhvegebase:latest \
  -f "JHVEGEBASE/Dockerfile" \
  "JHVEGEBASE"
 
# 重新推送  
docker push ghcr.io/secosun/jhvegebase:%DOCKER_IMAGE_VERSION%
docker push ghcr.io/secosun/jhvegebase:latest

else
  echo "镜像ghcr.io/secosun/jhvegebase已经存在！"
fi


existbase=$(docker inspect --type=image  ghcr.io/secosun/mysqlphpbase:latest | grep -c "LastTagTime")
if [ $existbase -ne 1 ]; then 
# 拉取最新的镜像
#docker pull ghcr.io/secosun/mysqlphpbase:latest || true
# 使用最新拉取的镜像作为缓存层
docker build \
  --cache-from ghcr.io/secosun/mysqlphpbase:latest \
  -t ghcr.io/secosun/mysqlphpbase:$DOCKER_IMAGE_VERSION \
  -t ghcr.io/secosun/mysqlphpbase:latest \
  -f "BASEPHPMYSQL/Dockerfile" \
  "BASEPHPMYSQL"

# 重新推送  
docker push ghcr.io/secosun/mysqlphpbase:$DOCKER_IMAGE_VERSION
docker push ghcr.io/secosun/mysqlphpbase:latest

else
  echo "镜像ghcr.io/secosun/mysqlphpbase已经存在！"
fi