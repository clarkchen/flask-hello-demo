
# Docker 范例
python 3.8.5
基于镜像 python:3.8.5


# 测试
## 构建
```
docker-compose -f docker-compose.test.yaml build
```
## 启动
```
docker-compose -f docker-compose.test.yaml up
```

# 正式
## 构建
```
docker-compose build
```
## 启动
```
docker-compose up
```
## docker run
```
docker run -p 5000:5000 -d clarkchenme/flask-hello

docker container stop $(docker container ls|awk '/flask/{print $1}')

```