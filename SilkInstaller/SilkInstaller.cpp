/*!
 *@file SilkInstaller.cpp
 *@brief Silk安装器
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
#include "SilkInstaller.h"

SilkInstaller::SilkInstaller()
{
    
}

QString SilkInstaller::cls_getAppPath()
{
    return(QStandardPaths::standardLocations(QStandardPaths::ConfigLocation)[0]);
}
