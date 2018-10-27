import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: alcoholOrder
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height
    minimumWidth: screen.width
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Alcohol Ordering")

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
          id: vodkaNemiroff
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vodka Nemiroff")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "1";
              GV.arrayTitle[order] = vodkaNemiroff.text;
              GV.arrayPrice[order] = 120;
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              alcoholOrder.hide();
          }
        }

        Button{
          id: vodkaGreenDay
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vodka GreenDay")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "2";
              GV.arrayPrice[order] = 110;
              GV.arrayTitle[order] = vodkaGreenDay.text;
              //console.log(GV.arrayTitle[order]);
              requestFunction(order);
              pageLoader.source = "orderAdd.qml";
              alcoholOrder.hide();
          }
        }

        Button{
          id: vodkaVozduh
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vodka Воздух")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "3";
              requestFunction(order);
              GV.arrayTitle[order] = vodkaVozduh.text
              pageLoader.source = "orderAdd.qml";
              alcoholOrder.hide();
          }
        }

        Button{
          id: vodkaFinlandia
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vodka Finlandia")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "4";
              requestFunction(order);
              GV.arrayTitle[order] = vodkaFinlandia.text;
              pageLoader.source = "orderAdd.qml";
              alcoholOrder.hide();
           }
        }

        Button{
          id: vodkaMorosha
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vodka Morosha")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "5";
              requestFunction(order);
              GV.arrayTitle[order] = vodkaMorosha.text;
              pageLoader.source = "orderAdd.qml";
              alcoholOrder.hide();
           }
        }

        Button{
          id: vodkaPrime
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Vodka Prime")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "6";
              requestFunction(order);
              GV.arrayTitle[order] = vodkaPrime.text;
              pageLoader.source = "orderAdd.qml";
              alcoholOrder.hide();
          }
        }
    }
    Text {
        id: headerText
        text: qsTr("Alcohol List")
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

