    import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: homeWindow
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Main Menu")

    Loader {
        id: pageLoader
    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 20
        rowSpacing: 50
        columnSpacing: 20
        //flow:  width < height ? GridLayout.LeftToRight : GridLayout.TopToBottom
        flow: GridLayout.TopToBottom
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                anchors.centerIn: parent
                text: "Заказы"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                pageLoader.source = "orderList.qml"
                homeWindow.hide();
            }
        }
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                anchors.centerIn: parent
                text: "Добавить Новое Блюдо"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                pageLoader.source = "orderAdd.qml"
                homeWindow.hide();
            }
        }
        Button{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label{
                anchors.centerIn: parent
                text: "Корзина"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked:
            {
                pageLoader.source = "bucketVar.qml"
                homeWindow.hide();
            }
          }
        Button{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Label{
                anchors.centerIn: parent
                text: "Администрировать Новый Заказ"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                pageLoader.source = "editOrder.qml";
                bucketVar.hide();
            }
        }
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                anchors.centerIn: parent
                text: "Наше Меню"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                pageLoader.source = "menuList.qml"
                homeWindow.hide();
            }
        }
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label{
                anchors.centerIn: parent
                text: "Складской Учет"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                pageLoader.source = "menuTableList.qml";
                homeWindow.hide();
            }
        }
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                anchors.centerIn: parent
                text: "Выйти Из Системы"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                Qt.quit();
            }
        }
    }
}
