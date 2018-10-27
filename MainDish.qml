import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: mainDishOrder
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("Main Course Ordering")

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
          id: mainSteak
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Steak")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "19";
              requestFunction(order);
              GV.arrayTitle[order] = mainSteak.text;
              pageLoader.source = "orderAdd.qml";
              mainDishOrder.hide();
          }
        }

        Button{
          id: mainClubSandwich
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Club Sandwich")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "20";
              requestFunction(order);
              GV.arrayTitle[order] = mainClubSandwich.text;
              pageLoader.source = "orderAdd.qml";
              mainDishOrder.hide();
          }
        }

        Button{
          id: mainHamburger
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Hamburger")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "21";
              requestFunction(order);
              GV.arrayTitle[order] = mainHamburger.text;
              pageLoader.source = "orderAdd.qml";
              mainDishOrder.hide();
          }
        }

        Button{
          id: mainPasta
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Pasta")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "22";
              requestFunction(order);
              GV.arrayTitle[order] = mainPasta.text;
              pageLoader.source = "orderAdd.qml";
              mainDishOrder.hide();
           }
        }

        Button{
          id: drinkShishkibab
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Shishkibab")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "23";
              requestFunction(order);
              GV.arrayTitle[order] = drinkShishkibab.text;
              pageLoader.source = "orderAdd.qml";
              mainDishOrder.hide();
           }
        }

        Button{
          id: drinkRizzotto
          Layout.fillHeight: true
          Layout.fillWidth: true
          text: qsTr("Rizzotto")
          font.pixelSize: parent.height * 0.05
          onClicked: {
              var order = "24";
              requestFunction(order);
              GV.arrayTitle[order] = drinkRizzotto.text;
              pageLoader.source = "orderAdd.qml";
              mainDishOrder.hide();
          }
        }
    }
    Text {
        id: headerText
        text: qsTr("Main Course List")
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

