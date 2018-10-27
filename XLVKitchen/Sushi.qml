import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow{
    id: sushiOrder
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("Sushi Ordering")

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
          id: sushiIrai
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Irai")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "43";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              sushiOrder.close();
          }
        }

        Button{
          id: sushiSyake
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Syake")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "44";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              sushiOrder.close();
          }
        }

        Button{
          id: sushiMaguro
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Maguro")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "45";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              sushiOrder.close();
          }
        }

        Button{
          id: sushiUnagi
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Unagi")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "46";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              sushiOrder.close();
           }
        }

        Button{
          id: sushiHamachi
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Hamachi")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "47";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              sushiOrder.close();
           }
        }

        Button{
          id: sushiIkura
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Ikura")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "48";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              sushiOrder.close();
          }
        }
    }
    Text {
        id: headerText
        text: qsTr("Sushi List")
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

