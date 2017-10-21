#-------------------------------------------------
#
# Copyright (C) 2003-2103 CamelSoft Corporation
#
#-------------------------------------------------

QT += qml quick webengine

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

win32{
    RESOURCES += VersionInfo.qrc
    RC_FILE = VersionInfo.rc
}
