import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: nonalcoholOrder
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("Common Drinks Ordering")

    function requestFunction(order)
    {
        GV.array[order]++;
        console.log(GV.array[order]);
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
          id: drinkSprite
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Sprite 0.5l.")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "13";
              requestFunction(order);
              GV.arrayTitle[order] = drinkSprite.text;
              pageLoader.source = "orderAdd.qml";
              nonalcoholOrder.hide();
          }
        }

        Button{
          id: drinkFanta
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Fanta 0.5l.")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "14";
              requestFunction(order);
              GV.arrayTitle[order] = drinkFanta.text;
              pageLoader.source = "orderAdd.qml";
              nonalcoholOrder.hide();
          }
        }

        Button{
          id: drinkCola
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Coca-Cola 0.5l.")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "15";
              requestFunction(order);
              GV.arrayTitle[order] = drinkCola.text;
              pageLoader.source = "orderAdd.qml";
              nonalcoholOrder.hide();
          }
        }

        Button{
          id: drinkPepsi
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Pepsi-Cola 0.5l.")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "16";
              requestFunction(order);
              GV.arrayTitle[order] = drinkPepsi.text;
              pageLoader.source = "orderAdd.qml";
              nonalcoholOrder.hide();
           }
        }

        Button{
          id: drinkMorshinska
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Morshinska 0.5l.")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "17";
              requestFunction(order);
              GV.arrayTitle[order] = drinkMorshinska.text;
              pageLoader.source = "orderAdd.qml";
              nonalcoholOrder.hide();
           }
        }

        Button{
          id: drinkBorjomi
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Borjomi 0.5l.")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "18";
              requestFunction(order);
              GV.arrayTitle[order] = drinkBorjomi.text;
              pageLoader.source = "orderAdd.qml";
              nonalcoholOrder.hide();
          }
        }
    }
    Text {
        id: headerText
        text: qsTr("Common Drinks List")
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

