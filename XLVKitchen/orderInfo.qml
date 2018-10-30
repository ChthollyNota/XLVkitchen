import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as C1
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: orderInfo
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Информация о заказе");

    Loader{
        id: pageLoader
    }
    Component.onCompleted: {
        console.log("----------------");
        console.log("HERE I COME");
        console.log("USING " + GV.indexOrderList + " ORDER");
        console.log("----------------");
        jsonLoader();
    }

    function jsonLoader(){
        var request = new XMLHttpRequest();
        var request_url = GV.serverUrl + "/get/orders?" + GV.loginInfo;
        console.log(request_url);
        var request_get = "GET";
        request.open(request_get, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4 && request.status === 200)
            {
                confirmButton.visible = true;
                exitButton.visible = true;
                confirmButton.text = "Взять Заказ На Выполнение";
                labelConst.text = "Ознакомтесь C Заказом";
                exitButton.text = "Выйти В Главное Меню";
            }
            if (request.readyState !== 4)
            {
                labelConst.text = "Идет загрузка заказа с сервера...";
            }
        }
        request.send();
    }

    Rectangle{
        id: labelRec
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.height * 0.1
        Label{
            id: labelConst
            anchors.centerIn: parent
            font.pixelSize: orderInfo.height * 0.05
        }
    }

    Button{
        id: confirmButton
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: exitButton.top
        height: parent.height * 0.1
        font.pixelSize: parent.height * 0.05
    }

    Button{
        id: exitButton
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.1;
        font.pixelSize: parent.height * 0.05
        onClicked: {
            pageLoader.source = "homePage.qml";
            orderInfo.hide();
        }
    }

}
