/*!
 *@file SilkInstaller.cpp
 *@brief Silk安装器
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
#include "SilkInstaller.h"
#include "quazip/JlCompress.h"
#include <QCoreApplication>
#include <QFileInfo>
#include <QDir>
#include <QDebug>

SilkInstaller::SilkInstaller():
    m_strAppPath("")
{
    
}

QString SilkInstaller::cls_getAppPath()
{
    m_strAppPath = QStandardPaths::standardLocations(QStandardPaths::ConfigLocation)[0] + "/";
    return(m_strAppPath);
}

bool SilkInstaller::Sub_ExtractFile(QString strInFile, QString strOutFile)
{
    QFile infile(strInFile);
    if (!infile.open(QIODevice::ReadOnly))
    {
        return(false);
    }
    QByteArray data = infile.readAll();
    QFile outfile(strOutFile);
    if (!outfile.open(QIODevice::WriteOnly | QIODevice::Append))
    {
        return(false);
    }
    outfile.write(data);
    infile.close();
    outfile.close();
    return(true);
}

bool SilkInstaller::Sub_ExtractZipFile(QString strInFile, QString strInFilePath, QString strOutPath)
{
    QuaZipFile infile(strInFile, strInFilePath);
    if (!infile.open(QIODevice::ReadOnly))
    {
        return(false);
    }
    QByteArray data = infile.readAll();
    QString outPath = strOutPath + strInFilePath;
    if (outPath.endsWith("/") == true)
    {
        QDir appDir(outPath);
        if (appDir.exists() != true)
        {
            appDir.mkpath(outPath);
        }
        return(true);
    }
    QFile outfile(outPath);
    if (!outfile.open(QIODevice::WriteOnly | QIODevice::Append))
    {
        return(false);
    }
    outfile.write(data);
    infile.close();
    outfile.close();
    return(true);
}

bool SilkInstaller::Sub_ExtractDir(QString strInFile, QString strOutPath)
{
    QuaZip zipInFile(strInFile);
    if (!zipInFile.open(QuaZip::mdUnzip)) {return(false);}

    int nFileCount = zipInFile.getEntriesCount();
    sShowMaxProgress(nFileCount);

    int nFileProgress = 0;
    bool hasFile = zipInFile.goToFirstFile();
    while(hasFile)
    {
        bool bRet = Sub_ExtractZipFile(zipInFile.getZipName(), zipInFile.getCurrentFileName(), strOutPath);
        if (bRet != true)
        {
            return(false);
        }
        bRet = zipInFile.goToNextFile();
        if (bRet != true)
        {
            return(true);
        }
        nFileProgress++;
        sShowProgress(nFileProgress);
    }
    return(true);
}

void SilkInstaller::cls_start()
{
    //判断文件夹是否有效
    QDir appDir(m_strAppPath);
    if (appDir.exists() != true)
    {
        appDir.mkpath(m_strAppPath);
    }
    QFileInfo appPath(m_strAppPath);
    if (appPath.isDir() != true)
    {
        emit sShowError(QStringLiteral("不是有效的文件路径."));
    }
    if (!m_strAppPath.endsWith("/") && !m_strAppPath.endsWith("\\"))
    {
        m_strAppPath += "/";
    }

    //解压文件
    QString strInFileName = QStringLiteral(":/release.z01");
    QString strOutFileName = QCoreApplication::applicationDirPath() + QStringLiteral("/release.zip");
    int index = 1;
    while(Sub_ExtractFile(strInFileName, strOutFileName))
    {
        index++;
        QString strIndex = QString::number(index).sprintf("%02d",index);
        strInFileName = QStringLiteral(":/release.z") + strIndex;
    }

    bool bRet = Sub_ExtractDir(strOutFileName, m_strAppPath);
    if (bRet != true)
    {
        emit sShowError(QStringLiteral("文件解压错误."));
    }
    QFile infile(strOutFileName);
    infile.remove();
}

void SilkInstaller::cls_setAppPath(QString strAppPath)
{
    m_strAppPath = strAppPath + "/";
}
