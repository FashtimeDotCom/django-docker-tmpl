# django-docker-tmpl

## Usage


#### Init Project using this template

```bash
export project_name=xxx
git clone https://github.com/JackonYang/django-docker-tmpl.git $project_name
cd $project_name
rm -rf .git
# Update README
git init && git add . && git commit -m'init project using https://github.com/JackonYang/django-docker-tmpl.git v0.1'
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
