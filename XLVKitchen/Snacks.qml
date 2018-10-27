import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow {
    id: appWindow
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("TEST")

    property int number: 0

    function makeOrder(index){
        GV.array[index]++;
        console.log("YOU ORDERED " + GV.arrayTitle[index]);
    }

    function jsonLoader()
    {
        console.log("jsonLoaderCheckpoint");
        var request = new XMLHttpRequest();
        var request_url = "http://api.torianik.online:5000/get/dishes";
        var get_request = "GET";
        var post_request ="POST";
        request.open(post_request, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4)
            {
                var status = request.status;
                if (request.status === 200) {
                    tableLoader(request.responseText);
                }
            }
        };
        request.send();
    }

    function tableLoader(response){
        console.log("tableLoaderCheckpoint");
        var dataBase = JSON.parse(response);
        var count = 0;
        for (var index = 0; index < dataBase.res.length; index++) {
          if (dataBase.res[index].tags[0] === "snack") {
               GV.dataBaseofIds[count] = index+1;
               console.log(GV.dataBaseofIds[count]);
               console.log("ID WAS ADDED");
               GV.dataBaseofTitles[count+1] = (dataBase.res[index].title).toString();
               console.log("TITLE WAS ADDED");
               console.log(GV.dataBaseofTitles[count]);
               GV.dataBaseofPrices[count+1] = (dataBase.res[index].cost);
               count++;
           }
        }
        tableSize(count);
    }

    function tableSize(count){
        GV.count = count;
        var firstSide = count;
        var secondSide = 1;
        console.log(firstSide);
        if (firstSide % 2 !== 0 && ((Math.round(Math.sqrt(firstSide)) * Math.round(Math.sqrt(firstSide))) !== firstSide)) { firstSide++;}
        if (((Math.sqrt(firstSide) * Math.sqrt(firstSide)) === firstSide)) {firstSide = Math.round(Math.sqrt(firstSide)); secondSide = firstSide;}
        if (firstSide % 2 === 0){
            while (firstSide > secondSide){
                if (firstSide % 2 === 0 && firstSide > secondSide)
                {
                    firstSide = firstSide / 2;
                    secondSide = secondSide * 2;
                }
                if (firstSide % 2 !== 0) {break;}
            }
         }
         GV.firstSide = firstSide;
         GV.secondSide = secondSide;

        console.log("1. " + GV.firstSide + " 2. " + GV.secondSide);
        if (firstSide < secondSide) {var swap = firstSide; firstSide = secondSide; secondSide = firstSide;}
        addButton();
    }

    function addButton(){
        for (var index = 0; index < GV.count; index++)
        {
            listModel.append({idshnik: GV.dataBaseofTitles[index+1]})
            number++;
        }
    }

    Component.onCompleted: {
        jsonLoader();
    }
    Loader{
        id: pageLoader
    }

    ListView {
        id: listView1index

        anchors.top: row.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right

        delegate: Item {
            id: item
            anchors.left: parent.left
            anchors.right: parent.right
            height: (appWindow.height * 0.2)

            Button {
                anchors.fill: parent
                anchors.margins: parent.height * 0.1


                text: idshnik
                font.pixelSize: appWindow.height * 0.05


                onClicked: {
                    textIndex.text = "You ordered " + text
                    GV.arrayTitle[GV.dataBaseofIds[index]] = GV.dataBaseofTitles[index+1];
                    GV.arrayPrice[GV.dataBaseofIds[index]] = GV.dataBaseofPrices[index+1];
                    makeOrder(GV.dataBaseofIds[index]);
                    console.log("------------------------------------------------------------");
                    console.log("DATABASE OF TITLES: " + GV.dataBaseofTitles[index+1]);
                    console.log("DATABASE OF COSTS: " + GV.dataBaseofPrices[index+1]);
                    console.log("INDEX IN FUNC: " + GV.dataBaseofIds[index] + " INDEX: " + index);
                }
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
                text: "Here will be displayed your last order!"
                font.pixelSize: indexRec.width * 0.05
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
        text: "FINISH ORDERS"
        font.pixelSize: parent.height * 0.05
        onClicked: {
            pageLoader.source = "orderAdd.qml"
            appWindow.hide();
        }
    }
}
