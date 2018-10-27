import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow {
    id: appWindow
    title: qsTr("Список заказов")
    width: screen.width
    height:screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    visible: true

    property int number: 0
    //TODO: complete method tableLoader
    //TODO: complete method jsonParse
    //TODO: complete method addInformation
    //TODO: add button
    //TODO: make status change
    //TODO: make status display

    function tableLoader(){
        var request = new XMLHttpRequest();
        var request_url = "http://api." + GV.serverUrl + ":5000/get/orders";
        var request_get = "GET";

        request.open(request_get, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4)
            {
                console.log("Json Parse");
                jsonParse(request.responseText);
            }
        }
        request.send();
    }

    function jsonParse(response)
    {
        var dataBase = JSON.parse(response);

        for (var index = 0; index < dataBase.res.length; index++)
        {
            if (dataBase.res[index].status === 1) {
                console.log("Generating Buttons");
                listModel.append({idshnik: dataBase.res[index].id, buttonText: "Подробнее о заказе"});
            }
        }
    }

    Component.onCompleted: {
        tableLoader();
    }

    ListView {
        id: listView1index

        anchors.top: row.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        delegate:
            Item {
            id: item
            anchors.left: parent.left
            anchors.right: parent.right
            height: (appWindow.height * 0.2)


            Button {
                anchors.left: item.left
                anchors.right: item.right
                anchors.top: item.top
                anchors.bottom: item.bottom
                anchors.topMargin: item.height * 0.3


                text: buttonText
                font.pixelSize: appWindow.height * 0.04


                onClicked: {
                        GV.indexOrderList = idshnik;
                }
            }
            Label{
                id: label
                anchors.left: item.left
                anchors.leftMargin: item.width * 0.45
                anchors.right: item.right
                anchors.top: item.top
                anchors.bottom: item.bottom
                anchors.bottomMargin: item.height * 0.7

                font.pixelSize: appWindow.height * 0.05
                text: "Заказ #" + idshnik
            }
        }

        model: ListModel {
            id: listModel
        }
    }
    Row {
        id: row
        height: parent.height * 0.1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            id: indexRec
            width: (appWindow.width)
            height: appWindow.height * 0.1

            Text {
                id: textIndex
                anchors.fill: indexRec
                text: "Выбирайте свободный заказ и приступайте к его выполнению!"
                font.pixelSize: indexRec.width * 0.02
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    Button
    {
        id: quitButton
        height: parent.height * 0.1
        width: appWindow.width
        anchors.top: listView1index.bottom
        anchors.left: appWindow.right
        anchors.right: appWindow.right
        anchors.bottom: appWindow.bottom
        text: "Выйти В Главное Меню"
        font.pixelSize: parent.height * 0.05
        onClicked: {
            pageLoader.source = "homePage.qml"
            appWindow.hide();
        }
    }
}
