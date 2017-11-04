/*!
 *@file main.cpp
 *@brief 程序主文件
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
#include <QCoreApplication>
#include <QStandardPaths>
#include <QFile>
#include <QDir>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    //建立桌面快捷方式
    QString strAppPath = "C:/Windows/System32/notepad.exe";
    QString strDesktopLink = QStandardPaths::writableLocation(QStandardPaths::DesktopLocation) + "/";
    strDesktopLink += "notepad.lnk";
    QFile fApp(strAppPath);
    fApp.link(strDesktopLink);

    //建立开始菜单快捷方式
    QString strMenuLink = QStandardPaths::writableLocation(QStandardPaths::ApplicationsLocation) + "/";
    strMenuLink += "notepad/";
    QDir pathDir;
    pathDir.mkpath(strMenuLink);
    strMenuLink += "notepad.lnk";
    fApp.link(strMenuLink);
    return(0);
}
