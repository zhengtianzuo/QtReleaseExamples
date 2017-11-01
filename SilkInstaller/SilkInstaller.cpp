/*!
 *@file SilkInstaller.cpp
 *@brief Silk安装器
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
#include "SilkInstaller.h"
#include <QFileInfo>
#include <QDir>

SilkInstaller::SilkInstaller():
    m_strAppPath("")
{
    
}

QString SilkInstaller::cls_getAppPath()
{
    return(QStandardPaths::standardLocations(QStandardPaths::ConfigLocation)[0]);
}

void SilkInstaller::cls_start()
{
    //判断文件夹是否有效
    QFileInfo appPath(m_strAppPath);
    if (appPath.isDir() != true) {emit sShowError("");}

    QDir appDir(m_strAppPath);
    if (appDir.exists() != true) {emit sShowError("");}


}

void SilkInstaller::cls_setAppPath(QString strAppPath)
{
    m_strAppPath = strAppPath;
}
