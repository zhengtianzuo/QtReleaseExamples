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
    void sShowMaxProgress(int nMax);
    void sShowProgress(int value);

private:
    bool Sub_ExtractFile(QString strInFile, QString strOutFile);
    bool Sub_ExtractZipFile(QString strInFile, QString strInFilePath, QString strOutPath);
    bool Sub_ExtractDir(QString strInFile, QString strOutPath);

    QString m_strAppPath;
};
