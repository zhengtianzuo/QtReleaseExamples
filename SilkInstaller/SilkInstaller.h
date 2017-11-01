/*!
 *@file SilkInstaller.h
 *@brief Silk安装器
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
#pragma once
#include <QObject>
#include <QStandardPaths>
#include <QDebug>

class SilkInstaller : public QObject
{
    Q_OBJECT
public:
    SilkInstaller();
    Q_INVOKABLE QString cls_getAppPath();
    Q_INVOKABLE void cls_start();
    Q_INVOKABLE void cls_setAppPath(QString strAppPath);

public slots:

signals:
    void sShowError(QString strError);

private:
    QString m_strAppPath;
};
