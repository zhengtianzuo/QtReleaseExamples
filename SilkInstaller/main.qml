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

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 600
    height: defaultMargin*5 + rowBtn.height + imgBack.height + colMore.height + btnStart.height + rowLicense.height
    title: qsTr("")
    flags: Qt.Window | Qt.FramelessWindowHint

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

    Column{
        spacing: defaultMargin

        Row{
            id: rowBtn
            spacing: defaultMargin/2
            anchors.right: parent.right
            anchors.rightMargin: defaultMargin/2
            BaseButton{
                id: btnMin
                anchors.top: parent.top
                anchors.topMargin: defaultMargin/2
                height: 20
                width: 20
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
                anchors.topMargin: defaultMargin/2
                height: 20
                width: 20
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
            height: 200
            width: mainWindow.width
            source: "qrc:/images/back.jpg"
        }

        FolderDialog {
            id: folderDlg
            onAccepted: {
                var path = folderDlg.currentFolder.toString();
                path = path.replace(/^(file:\/{3})/,"");
                edtPath.text = path;
            }
        }

        Column{
            id: colMore
            height: 0
            width: parent.width
            spacing: defaultMargin/2
            visible: false

            Row{
                height: 24
                width: parent.width*0.8
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: defaultMargin/2

                Rectangle{
                    height: 24
                    width: parent.width - btnPath.width
                    border.color: "#000000"
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
                    height: 24
                    width: 120
                    txtText: qsTr("浏览")
                    onSClicked: {
                        folderDlg.open();
                    }
                }
            }
            Row{
                height: 24
                width: parent.width*0.8
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
            }
            Row{
                height: 24
                width: parent.width*0.8
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: defaultMargin/2

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
            height: 32
            width: 200
            anchors.horizontalCenter: parent.horizontalCenter
            txtText: qsTr("开始")
        }

        Row{
            id: rowLicense
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: defaultMargin
            anchors.right: parent.right
            anchors.rightMargin: defaultMargin

            BaseCheckBox {
                id: chkLicense
                height: 24
                text: qsTr("阅读并同意")
                checked: true
                onToggled:{

                }
            }

            BaseLinkText {
                id: btnLicense
                height: 24
                anchors.top: parent.top
                anchors.topMargin: defaultMargin/2
                txtText: '<html></style><a>使用协议</a></html>'
                color: "blue"
                onSClicked: {

                }
            }

            Item{
                height: 24
                width: parent.width - chkLicense.width - btnLicense.width - chkMore.width - btnMore.width
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
                anchors.top: parent.top
                anchors.topMargin: defaultMargin/2
                text: '<html></style><a>自定义选项</a></html>'
                color: "blue"
                onSClicked: {
                    chkMore.checked = !chkMore.checked;
                    onChkMore();
                }
            }
        }
    }
}
