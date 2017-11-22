/*!
 *@file main.cpp
 *@brief 程序主文件
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
#include <QCoreApplication>
#include <QSettings>

//!@brief 注册表字段
#ifdef Q_OS_WIN32
const QString strUninstall =
    "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\";
const QString strPublisher = "Publisher";
const QString strDisplayName = "DisplayName";
const QString strDisplayIcon = "DisplayIcon";
const QString strDisplayVersion = "DisplayVersion";
const QString strInstallLocation = "InstallLocation";
const QString strUninstallString = "UninstallString";
#endif

//获取注册表
QString getRegValue(
    QString &strPath, QString strItemName)
{
    QSettings reg(strPath, QSettings::NativeFormat);
    return (reg.value(strItemName).toString());
}

//写入注册表
void setRegValue(
    QString strPath, QString strItemName, QString strItemData)
{
    QSettings reg(strPath, QSettings::NativeFormat);
    reg.setValue(strItemName, strItemData);
}

//删除注册表
void delRegValue(
    QString strPath, QString strItemName)
{
    QSettings reg(strPath, QSettings::NativeFormat);
    if (strItemName != nullptr)
    {
        reg.remove(strItemName);
    }
    else
    {
        reg.remove(strPath);
    }
}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QString strAppPath = "MyApp";
    QString strAppName = QStringLiteral("这是程序的名称");
    QString strAppIcon = "C:/Windows/System32/notepad.exe";
    QString strAppVersion = "v1.0.0.0";

    //写入卸载信息
    QString strUninstall(strUninstall);
    strUninstall += strAppPath;
    setRegValue(strUninstall, strDisplayName, strAppName);
    setRegValue(strUninstall, strDisplayIcon, strAppIcon);
    setRegValue(strUninstall, strDisplayVersion, strAppVersion);
    setRegValue(strUninstall, strPublisher, "zhengtianzuo");
    setRegValue(strUninstall, strUninstallString, strAppIcon);

    return(0);
}
