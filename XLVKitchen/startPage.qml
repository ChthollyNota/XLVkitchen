import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow
{
    id: startWindow
    visible: true
    width: screen.width
    height: screen.height
    maximumHeight: screen.height
    maximumWidth: screen.width
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    title: qsTr("Start Page");

    Loader{
        id: pageLoader
    }

    Rectangle {
        id: loginRec
        border.width: 1
        border.color: "black"
        y: parent.height * 0.2
        height: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width * 0.1
        anchors.rightMargin: parent.width * 0.1
        TextInput
        {
            id: loginTxt
            text: GV.serverUrl
            anchors.fill: parent
            anchors.margins: 3
            font.pixelSize: parent.height * 0.7
        }
    }
    Text
    {
        height: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width * 0.1
        anchors.rightMargin: parent.width * 0.1
        font.pixelSize: parent.height * 0.05
        text: 'Введите Aдрес Cервера'
        anchors.bottom: loginRec.top
    }

    Button
    {
        id: loginButton
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.1
        anchors.margins: parent.width * 0.1
        text: "Войти В Систему"
        font.pixelSize: parent.height * 0.05
        onClicked: {
            GV.serverUrl = loginTxt.text
            startWindow.visible = false;
            pageLoader.source = "authWindow.qml";
        }
    }
}

