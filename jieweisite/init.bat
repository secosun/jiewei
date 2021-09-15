set DOCKER_IMAGE_VERSION="v2"
set /p passwordcompose=<BASEPHPMYSQL\compose.pwd
docker login ghcr.io -u secosun --password %passwordcompose%

docker inspect --type=image  ghcr.io/secosun/jhvegebase:%DOCKER_IMAGE_VERSION% |  find /C "LastTagTime" >temp
set /p existbase=<temp
if %existbase%==1 goto A 

:: 拉取最新的镜像
::::docker pull ghcr.io/secosun/jhvegebase:latest
::  --cache-from ghcr.io/secosun/jhbase:latest
::  --no-cache
:: 使用最新拉取的镜像作为缓存层
docker build ^
  -t ghcr.io/secosun/jhvegebase:%DOCKER_IMAGE_VERSION% ^
  -f "JHVEGEBASE\Dockerfile" ^
  "JHVEGEBASE"
 

:: 重新推送  
::docker push ghcr.io/secosun/jhvegebase:%DOCKER_IMAGE_VERSION%
::docker push ghcr.io/secosun/jhvegebase:latest

:A
docker inspect --type=image  ghcr.io/secosun/mysqlphpbase:%DOCKER_IMAGE_VERSION% |  find /C "LastTagTime" >temp
set /p existbase=<temp
if %existbase%==0 goto B 
:: 拉取最新的镜像
::::docker pull ghcr.io/secosun/mysqlphpbase:latest
:: 使用最新拉取的镜像作为缓存层
::  --cache-from ghcr.io/secosun/mysqlphpbase:latest
::  --no-cache
docker build ^
  -t ghcr.io/secosun/mysqlphpbase:%DOCKER_IMAGE_VERSION% ^
  -f "BASEPHPMYSQL/Dockerfile" ^
  "BASEPHPMYSQL"

:: 重新推送  
::docker push ghcr.io/secosun/mysqlphpbase:%DOCKER_IMAGE_VERSION%
::docker push ghcr.io/secosun/mysqlphpbase:latest
:B
del  temp
echo init commpleted!