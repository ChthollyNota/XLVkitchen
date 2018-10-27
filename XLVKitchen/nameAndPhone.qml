import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import "GlobalVariables.js" as GV

ApplicationWindow {
 id: nameAndPhoneWindow
 visible: true
 width: screen.width
 height: screen.height
 minimumHeight: screen.height * 0.8
 minimumWidth: screen.width * 0.8
 maximumHeight: screen.height
 maximumWidth: screen.width
 title: qsTr("Корзина")

        Loader {
            id: pageLoader
        }
        Rectangle  {
        id: loginPg
        width: screen.width
        height: screen.height
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
                text: GV.clName
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
            text: 'Имя и Фамилия'
            anchors.bottom: loginRec.top
        }
        Rectangle
        {
            id: passRec
            y: parent.height * 0.5
            height: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.1
            anchors.rightMargin: parent.width * 0.1
            anchors.left: parent.left
            anchors.right: parent.right
            border.width: 1
            border.color: "black"
            TextInput
            {
                id: passTxt
                anchors.fill: parent
                text: GV.phNumber


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
            text: 'Телефон'
            anchors.bottom: passRec.top
        }
        Button
        {
            id: acceptButton
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height * 0.1
            anchors.margins: parent.width * 0.1
            text: "Подтвердить"
            font.pixelSize: parent.height * 0.05
            onClicked:
            {
                GV.name = loginTxt.text;
                GV.phone = passTxt.text;
                acceptButton.visible = false;
                nextStepButton.visible = true;
            }
        }
        Button{
            id: nextStepButton
            visible: false
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height * 0.1
            anchors.margins: parent.width * 0.1
            text: "Следующий Шаг"
            font.pixelSize: parent.height * 0.05
            onClicked: {
                pageLoader.source = "AcceptingOrder.qml";
                nameAndPhoneWindow.hide();
            }
        }
    }
}
