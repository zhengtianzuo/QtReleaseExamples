#-------------------------------------------------
#
# Copyright (C) 2003-2103 CamelSoft Corporation
#
#-------------------------------------------------

QT += qml quick widgets

CONFIG += c++11

SOURCES += \
    main.cpp \
    SilkInstaller.cpp

HEADERS += \
    SilkInstaller.h

RESOURCES += qml.qrc
RESOURCES += qml1.qrc \
    qml2.qrc \
    qml3.qrc \
    qml4.qrc \
    qml5.qrc \
    qml6.qrc \
    qml7.qrc \
    qml8.qrc \
    qml9.qrc \
    qml10.qrc \
    qml11.qrc \
    qml12.qrc \
    qml13.qrc \
    qml14.qrc \
    qml15.qrc \
    qml16.qrc \
    qml17.qrc \
    qml18.qrc \
    qml19.qrc

LIBS+= -L$$PWD/quazip -lzlib

include(quazip/quazip.pri)
DEFINES+= QUAZIP_BUILD

win32{
    RC_FILE = SilkInstaller.rc
}
