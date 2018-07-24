# django-docker-tmpl

## Usage


#### Init Project using this template

```bash
export project_name=xxx
git clone https://github.com/JackonYang/django-docker-tmpl.git $project_name
cd $project_name
rm -rf .git
# Update README
git init && git add . && git commit -m'init project using https://github.com/JackonYang/django-docker-tmpl.git v0.2'
git push -f xxx master
```

#### Env Check

```bash
$ make build
$ make debug
root@django-docker:/src# make test
```

```bash
root@django-docker:/src# make server
```

access [http://127.0.0.1:8000/heartbeat/](http://127.0.0.1:8000/heartbeat/) in browser.


## Services

可选的服务列表:

- MySQL
- MongoDB
- ES & Kibana

默认不会随着 web 服务的 container 一起启动。

如果项目需要，更新下 docker-compose.yml 的 depends_on


#### MongoDB Dump & Restore

MongoDB 容器启动时，可以 restore database dump。

用法：

1. dump MongoDB database，例如，dump 文件在 '/mnt/data/proj-name/dump' 目录下，proj-name 建议改成项目名字。
2. docker-compose.yml 里将 '/mnt/data/proj-name/dump' 改成 dump 文件夹位置

docker-compose 拉起环境时，会自动 restore。

#### Kibana

```bash
$ make kibana
```

then, open [http://127.0.0.1:5600/](http://127.0.0.1:5600/) in browser to play with Kibana


## Debug Tools

#### HTTP Mock

```bash
$ cd deploy
$ make build
$ make run
```

access [http://127.0.0.1:5051/heartbeat/](http://127.0.0.1:5051/heartbeat/) to confirm it is working


then we can add new API and fake data inside to debug with


## FAQ

#### settings.DATABASES is improperly configured.

**复现 step**

1. 登录一个带 user/admin 系统的 project
2. 初始化这个项目，并访问任何一个页面。
3. 报错：settings.DATABASES is improperly configured.

**Root cause analysis**

1. 登录其他 project 之后，cookie 里有 session
2. 访问这个项目的页面时，如果 enable AuthenticationMiddleware，则会先检查 session。
3. session 应该存在数据库里，而数据库配置错误。所以，抛异常。

**解决方案**

有 2 个方法：

1. 配一个 database，

比如：

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

2. disable AuthenticationMiddleware

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    # 'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```
