/*!
 *@file main.qml
 *@brief 主文件
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 600
    height: defaultMargin*5 + rowBtn.height + imgBack.height + colMore.height + btnStart.height + rowLicense.height
    title: qsTr("")
    flags: Qt.Window | Qt.FramelessWindowHint
    font.family: "Microsoft YaHei"
    font.pixelSize: 15
    Component.onCompleted: {
        edtPath.text = silkInstaller.cls_getAppPath();
    }

    property int defaultMargin: 12

    function onChkMore(){
        if (chkMore.checked){
            colMore.height = 80;
            colMore.visible = true;
        }else{
            colMore.height = 0;
            colMore.visible = false;
        }
    }

    MouseArea{
        anchors.fill: parent
        property point clickPos: "0,0"
        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            mainWindow.setX(mainWindow.x+delta.x)
            mainWindow.setY(mainWindow.y+delta.y)
        }
    }

    FolderDialog {
        id: folderDlg
        onAccepted: {
            var path = folderDlg.currentFolder.toString();
            path = path.replace(/^(file:\/{3})/,"");
            edtPath.text = path;
        }
    }

    Rectangle{
        id: rect
        color: "#148014"
        anchors.fill: parent
    }

    RectangularGlow {
        anchors.fill: rect
        glowRadius: 10
        spread: 0.0
        color: "white"
        cornerRadius: 10
    }

    Column{
        width: parent.width
        spacing: defaultMargin

        Row{
            id: rowBtn
            spacing: defaultMargin/2
            anchors.right: parent.right
            anchors.rightMargin: defaultMargin
            BaseButton{
                id: btnMin
                anchors.top: parent.top
                anchors.topMargin: defaultMargin
                height: 24
                width: 24
                imgEntered: "qrc:/images/min(3).png"
                imgExited: "qrc:/images/min.png"
                imgPressed: "qrc:/images/min(1).png"
                onSClicked: {
                    showMinimized();
                }
            }
            BaseButton{
                id: btnClose
                anchors.top: parent.top
                anchors.topMargin: defaultMargin
                height: 24
                width: 24
                imgEntered: "qrc:/images/close(3).png"
                imgExited: "qrc:/images/close.png"
                imgPressed: "qrc:/images/close(1).png"
                onSClicked: {
                    Qt.quit();
                }
            }
        }

        Image {
            id: imgBack
            height: 240
            width: parent.width*0.9
            anchors.horizontalCenter: parent.horizontalCenter
            //source: "qrc:/images/back.jpg"

            Image {
                id: imgLogo
                anchors.centerIn: parent
                //source: "qrc:/images/Logo.png"
            }
        }


        Column{
            id: colMore
            height: 0
            width: parent.width
            spacing: defaultMargin
            visible: false

            Row{
                height: 32
                width: parent.width*0.9
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: defaultMargin/2

                Rectangle{
                    height: 32
                    width: parent.width - btnPath.width
                    border.color: "#148014"
                    border.width: 1

                    TextEdit{
                        id: edtPath
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                        height: parent.height-2
                        width: parent.width-2
                        selectByKeyboard: true
                        selectByMouse: true
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                BaseButton{
                    id: btnPath
                    height: 32
                    width: 60
                    txtText: qsTr("浏览")
                    onSClicked: {
                        folderDlg.open();
                    }
                }
            }
            Row{
                height: 32
                width: parent.width*0.9
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: defaultMargin/2

                BaseCheckBox {
                    id: chkShort
                    height: 24
                    text: qsTr("生成快捷方式")
                    checked: true
                    onToggled:{

                    }
                }
                BaseCheckBox {
                    id: chkQuick
                    height: 24
                    text: qsTr("添加到快速启动栏")
                    checked: true
                    onToggled:{

                    }
                }
                BaseCheckBox {
                    id: chkAuto
                    height: 24
                    text: qsTr("开机自动启动")
                    checked: true
                    onToggled:{

                    }
                }
            }
        }

        BaseButton{
            id: btnStart
            height: 48
            width: 240
            anchors.horizontalCenter: parent.horizontalCenter
            txtText: qsTr("立即安装")
            onClicked: {
                silkInstaller.cls_start();
            }
        }

        Row{
            id: rowLicense
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: defaultMargin*2
            anchors.right: parent.right
            anchors.rightMargin: defaultMargin

            BaseCheckBox {
                id: chkLicense
                height: 24
                text: qsTr("阅读并同意")
                checked: true
                onToggled:{
                    btnStart.enabled = checked;
                }
            }

            BaseLinkText {
                id: btnLicense
                height: 24
                anchors.top: chkLicense.top
                anchors.topMargin: 2
                txtText: '<html></style><a>使用协议</a></html>'
                color: "blue"
                onSClicked: {

                }
            }

            Item{
                height: 24
                width: parent.width - chkLicense.width - btnLicense.width - chkMore.width - btnMore.width - defaultMargin
            }

            BaseCheckBox {
                id: chkMore
                height: 24
                width: 24
                imgChecked: "qrc:/images/down.png"
                imgUnchecked: "qrc:/images/up.png"
                onToggled:{
                    onChkMore();
                }
            }

            BaseLinkText {
                id: btnMore
                height: 24
                anchors.top: chkMore.top
                anchors.topMargin: 2
                text: '<html></style><a>自定义选项</a></html>'
                color: "blue"
                onSClicked: {
                    chkMore.checked = !chkMore.checked;
                    onChkMore();
                }
            }
        }
    }

    Connections{
        target: silkInstaller
        onSShowError:{

        }
    }

}
