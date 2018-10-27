import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow {
    id: bucketVar
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Корзинное Меню")

    Loader {
        id: pageLoader
    }

    GridLayout {
       anchors.fill: parent
       anchors.topMargin: parent.height * 0.1
       anchors.bottomMargin: parent.height * 0.1
       anchors.leftMargin: parent.width * 0.1
       anchors.rightMargin: parent.width * 0.1
       rowSpacing: 50
       columnSpacing: 20
       flow: GridLayout.TopToBottom

       Button{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Label{
               anchors.centerIn: parent
               text: "Сформировать Заказ"
               font.pixelSize: parent.width * 0.05
               color: "black"
           }
           onClicked: {
               pageLoader.source = "nameAndPhone.qml"
               bucketVar.hide();
           }
       }
       Button{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Label{
               anchors.centerIn: parent
               text: "Администрировать Новый Заказ"
               font.pixelSize: parent.width * 0.05
               color: "black"
           }
           onClicked: {
               pageLoader.source = "editOrder.qml";
               bucketVar.hide();
           }
       }

       Button{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Label{
               anchors.centerIn: parent
               text: "Проверить Вашу Корзину"
               font.pixelSize: parent.width * 0.05
               color: "black"
           }
           onClicked: {
               pageLoader.source = "tableOrder.qml"
               bucketVar.hide();
           }
       }

       Button{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Label{
               id: wipeLabel
               anchors.centerIn: parent
               text: "Очистить Вашу Корзину"
               font.pixelSize: parent.width * 0.05
               color: "black"
           }
           onClicked: {
                GV.wipeOrderData();
                wipeLabel.text = "Корзина Очищенна";
           }
       }

       Button{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Label{
                anchors.centerIn: parent
                text: "Вернуться В Главное Меню"
                font.pixelSize: parent.width * 0.05
                color: "Black"
           }
           onClicked: {
               pageLoader.source = "homePage.qml"
               wipeLabel.text  = "Очистить Вашу Корзину"
               bucketVar.hide();
           }
       }
    }
}
