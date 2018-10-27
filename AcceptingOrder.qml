import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as C1
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: bucketGrid
    height: screen.height
    width: screen.width
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    visible: true;
    title: "Заказ"
    Loader{
        id: pageLoader
    }

    GridLayout{
        anchors.topMargin: 0
        anchors.fill: parent
        anchors.margins: 20
        anchors.bottomMargin: parent.height * 0.3
        rowSpacing: 20
        columnSpacing: 20
        flow: GridLayout.TopToBottom
        Text
        {
            height: parent.height * 0.05
            Layout.fillWidth: true
            font.pixelSize: parent.height * 0.05
            text: 'Город:'
        }
        Rectangle{
            id: cityRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.width: 1
            border.color: "black"
            TextInput{
                id: cityTxt
                anchors.fill: parent
                anchors.margins: 3
                font.pixelSize: parent.height * 0.7
            }
        }
        Text
        {
            height: parent.height * 0.05
            Layout.fillWidth: true
            font.pixelSize: parent.height * 0.05
            text: 'Улица:'
        }
        Rectangle{
            id: streetRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.width: 1
            border.color: "black"
            TextInput{
                id: streetTxt
                anchors.fill: parent
                anchors.margins: 3
                font.pixelSize: parent.height * 0.7
            }
        }
        Text
        {
            height: parent.height * 0.05
            Layout.fillWidth: true
            font.pixelSize: parent.height * 0.05
            text: 'Номер Дома:'
        }
        Rectangle{
            id: streetIdRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.width: 1
            border.color: "black"
            TextInput{
                id: streetIdTxt
                anchors.fill: parent
                anchors.margins: 3
                font.pixelSize: parent.height * 0.7
            }
        }
        Text
        {
            height: parent.height * 0.05
            Layout.fillWidth: true
            font.pixelSize: parent.height * 0.05
            text: 'Номер Квартиры:'
        }
        Rectangle{
            id: apartamentRec
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.width: 1
            border.color: "black"
            TextInput{
                id: apartamentTxt
                anchors.fill: parent
                anchors.margins: 3
                font.pixelSize: parent.height * 0.7
            }
        }
    }

    Button{
        id: quitButton
        visible: true
        height: bucketGrid.height * 0.1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        text: "Выйти В Главное Меню"
        font.capitalization: Font.Capitalize
        font.pixelSize: bucketGrid.height * 0.05
        onClicked:
        {
            console.log("Quit Button was pressed...");
            GV.flag = true;
            console.log(GV.flag);
            GV.wipeOrderData();
            pageLoader.source = "homePage.qml";
            bucketGrid.hide();
        }
    }
    function orderAccept(){
        var ID = 0;

        var request = new XMLHttpRequest();
        var request_url = "http://api." + GV.serverUrl + ":5000/get/orders";
        var request_get = "GET";

        request.open(request_get, request_url, true);

        request.onreadystatechange = function(){
            if (request.readyState === 4 && request.status === 200){
                    ID = request.res.length;
            }
        }
        request.send();

        request = new XMLHttpRequest();
        request_url = "http://api/" + GV.serverUrl + ":5000/confirm/order/" + ID+1;
        request_get = "GET";

        request.open(request_get, request_url, true);

        request.onreadystatechange = function(){
            console.log(request.status);
        }
        request.send();
    }

    function orderMaking(town, vulica, vulicaId, apartaments){
        var madeOrders = [0];
        var indexOrders = 0;
        var City = town;
        var Street = vulica;
        var StreetNumber = vulicaId;
        var Resident = apartaments;
        var request_url = "http://api." + GV.serverUrl +":5000/make_order"
        var request_json = "{"
        request_json = request_json + '"' + "address" + '"' + ":" + '"' + City + " " + Street + " " + StreetNumber + " " + Resident + '"' + ',"name":"' + GV.name + '","phone":"' + GV.phone +  '"';
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
        console.log(request_url);
        console.log(request_json);
        //

        var request = new XMLHttpRequest();
        var request_get = "GET";
        var request_post = "POST";
        request.open(request_post, request_url, true);
        request.setRequestHeader("Content-Type", "application/json");
        request.onreadystatechange = function(){
            if(request.readyState === 4){
                GV.status = request.status;
                console.log (request.message);
                if (GV.status !== 200) {getData.text = "Ошибочка! Свяжитесь с Администратором!"} else {getData.text = "Заказ Был Успешно Отправлен!"; orderAccept();};
            }

        }
        request.send(request_json);
    }
    Button{
        id: getData
        height: bucketGrid.height * 0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        text: "Сделать Заказ"
        font.capitalization: Font.Capitalize
        font.pixelSize: bucketGrid.height * 0.05
        onClicked:
        {
            console.log("Send Button was pressed!");
            console.log(GV.flag);
            if (GV.flag === true){
            console.log("Atributes were sent to Function...");
            orderMaking(cityTxt.text, streetTxt.text, streetIdTxt.text, apartamentTxt.text);
            }
            GV.flag = false;
        }
    }
}
