import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow{
    id: rollsOrder
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("Rolls Ordering")

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
          id: rollCalifornia
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("California")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "25";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              rollsOrder.hide();
          }
        }

        Button{
          id: rollGreenDragon
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Green Dragon")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "26";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              rollsOrder.hide();
          }
        }

        Button{
          id: rollRedDragon
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Red Dragon")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "27";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              rollsOrder.hide();
          }
        }

        Button{
          id: rollWhiteDragon
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("White Dragon")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "28";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              rollsOrder.hide();
           }
        }

        Button{
          id: rollVegeterian
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vegeterian")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "29";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              rollsOrder.hide();
           }
        }

        Button{
          id: rollWithCucumber
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("With Cucumber")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "30";
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              rollsOrder.hide();
          }
        }
    }
    Text {
        id: headerText
        text: qsTr("Rolls List")
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

