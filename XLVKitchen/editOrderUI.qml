import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as C1
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: editOrder
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Edit Order");

    function jsonBuild(){
            var madeOrders = [0];
            var indexOrders = 0;
            var request_json = "{"
            request_json = request_json + '"' + "address" + '"' + ":" + '"' + GV.adress + '"' + ',"name":"' + GV.name + '","phone":"' + GV.phone +  '"';
            request_json = request_json + "," + '"' + "dishes" + '"' + ":[";
            for (var index = 0; index < GV.arrayLength; index++)
            {
                if (GV.array[index] > 0) {indexOrders++; madeOrders[indexOrders] = index;}
            }

            for (index = 1; index < madeOrders.length; index++)
            {
                console.log("ID: " + madeOrders[index]);
                console.log("Among: " + GV.array[madeOrders[index]]);
                console.log("Length: " + GV.arrayLength);
                if (madeOrders.length - 1 != index){
                    request_json = request_json + "{" + '"' + "id" + '"' + ":" + madeOrders[index] + "," + '"' + "number" + '"' + ":" + GV.array[madeOrders[index]] + "},";
                } else { request_json = request_json + "{" + '"' + "id" + '"' + ":" + madeOrders[index] + "," + '"' + "number" + '"' + ":" + GV.array[madeOrders[index]] + "}";
              }
            }
            request_json = request_json + "]}";
            console.log(request_json);
            confirmOrder(request_json);
    }

    function confirmOrder(request_json){
        if (GV.flagOnEdit === false){
            var request = new XMLHttpRequest();
            var orderId = 0;
            orderId = GV.indexOrder;
            var request_url = GV.serverUrl + "/confirm/order/" + orderId + "?" + GV.loginInfo;
            var get_request = "GET";
            request.open(get_request, request_url, true);
            request.onreadystatechange = function(){
                if (request.readyState === 4 && request.status === 200)
                {
                    console.log(request.message);
                    passRec.visible = false;
                    loginButtonLabel.text = "Заказ был успешно подтвержден!"
                    GV.flagOnEdit = false;
                }
            }
            request.send();
        } else{
            request = new XMLHttpRequest();
            orderId = GV.indexOrder;
            request_url = GV.serverUrl + "/update_confirm/order/" + orderId + "?" + GV.loginInfo;
            get_request = "GET";
            var post_request = "POST";
            request.open(post_request, request_url, true);
            request.setRequestHeader("Content-Type", "application/json");
            request.onreadystatechange = function(){
                if (request.readyState === 4 && request.status === 200)
                {
                    console.log(request.message);
                    passRec.visible = false;
                    loginButtonLabel.text = "Заказ был успешно подтвержден!"
                    GV.wipeOrderData();
                    GV.flagOnEdit = false;
                }
            }
            request.send(request_json);
        }
    }

    function editOrderMeth(){
        GV.flagOnEdit = true
    }

    Loader{
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
            Label
            {
                id: loginTxt
                anchors.fill: parent
                anchors.margins: 3
                text: GV.phNumber
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
            text: 'Телефонный Номер Пользователя'
            anchors.bottom: loginRec.top
        }
        Button
        {
            id: passRec
            visible: true
            y: parent.height * 0.5
            height: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.1
            anchors.rightMargin: parent.width * 0.1
            anchors.left: parent.left
            anchors.right: parent.right
            Label{
                id: passLabel
                anchors.centerIn: parent
                text: "Изменить Заказ"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                editOrderMeth();
                editOrder.hide();
                pageLoader.source = "tableOrder.qml"
            }
        }
        Button
        {
            id: loginButton
            visible: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height * 0.1
            anchors.margins: parent.width * 0.1
            Label{
                id: loginButtonLabel
                anchors.centerIn: parent
                text: "Сформировать Заказ"
                font.pixelSize: screen.height * 0.05
                color: "black"
            }
            onClicked: {
                jsonBuild();
                if (passRec.visible == false){
                editOrder.hide();
                pageLoader.source = "bucketVar.qml"
                }
            }
        }
    }
}
