import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow{
    id: setOrder
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("Sets Ordering")

        function requestFunction(order)
        {
            var request = new XMLHttpRequest();
            var request_url = "http://api.torianik.online:5000/order?createOrder=" + order;
            var get_request = "GET";
            var post_request ="POST";
            request.open(post_request, request_url, true);
            request.onreadystatechange = function(){
                if (request.readyState === 4 && request.status === 200)
                {
                    var dataBase = JSON.parse(request.responseText);
                    var status = dataBase.status;
                    if (request.status === 200) {
                          console.log(dataBase.status)
                    }
                }
            };
            request.send();
            return status;
        }
    Loader{
        id: pageLoader
    }

    GridLayout {
        anchors.topMargin: parent.height * 0.1
        anchors.fill: parent
        anchors.margins: 20
        rowSpacing: 50
        columnSpacing: 20
        columns: 3
        rows: 2
        //flow: width < height ? GridLayout.LeftToRight : GridLayout.TopToBottom
        flow: GridLayout.TopToBottom

        Button{
          id: setFourDragons
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Four Dragons")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "37";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              setOrder.hide();
          }
        }

        Button{
          id: setBritania
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Britania")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "38";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              setOrder.hide();
          }
        }

        Button{
          id: setAnimeBomb
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Anime Bomb")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "39";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              setOrder.hide();
          }
        }

        Button{
          id: setVietnamWar
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vietnam War")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "40";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              setOrder.hide();
           }
        }

        Button{
          id: setPenguin
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Penguin's Set")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "41";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              setOrder.hide();
           }
        }

        Button{
          id: setVegeterian
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vegeterian")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "42";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              setOrder.hide();
          }
        }
    }
    Text {
        id: headerText
        text: qsTr("Sets List")
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.01
        anchors.topMargin: 0
        transformOrigin: Item.Center
        elide: Text.ElideMiddle
        fontSizeMode: Text.Fit
        font.pixelSize: parent.height * 0.05
    }
}

