TEMPLATE=subdirs
SUBDIRS= src

CONF.files = conf/*.conf
CONF.path = /usr/share/mymeego/conf
INSTALLS += CONF

DAEMON.files = daemon/*.py
DAEMON.path = /usr/share/mymeego/scripts
INSTALLS += DAEMON

BACKEND.files = conf/mymeego-backend
BACKEND.path = /usr/bin
INSTALLS += BACKEND

SERVICE.files = conf/org.mymeego.Backend
SERVICE.path = /usr/share/dbus-1/services
INSTALLS += SERVICE
