/*!
 *@file main.qml
 *@brief 主文件
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebEngine 1.4

ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Qml程序版本信息")

    WebEngineView{
        id: webEngineView
        anchors.fill: parent
        url: "http://www.camelstudio.cn"
    }
}
