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
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("TEST")

    property int number: 0

    //TODO: complete Method addOrder
    function addOrder(index){
        GV.array[GV.dataBaseofIds[index]]++;

        console.log("---------------------------");
        console.log("Adding order into bucket...");

        GV.arrayPrice[GV.dataBaseofIds[index]] = GV.dataBaseofPrices[GV.dataBaseofIds[index]] * GV.array[GV.dataBaseofIds[index]];
        console.log("GLOBAL PRICE: " + GV.arrayPrice[index]);

        GV.arrayTitle[GV.dataBaseofIds[index]] = GV.dataBaseofTitles[GV.dataBaseofIds[index]];
        console.log("GLOBAL TITLE: " + GV.arrayTitle[index]);

        console.log("COUNT: " + GV.array[GV.dataBaseofIds[index]]);

        if (GV.dataBaseofIds[index] > GV.arrayLength) {GV.arrayLength = GV.dataBaseofIds[index]+1; console.log("BLACK");}
        console.log("BASIC LENGTH OF ARRAY IS: " + GV.arrayLength + " ALTERNATIVE: " + GV.dataBaseofIds[index]);
    }

    function jsonLoader()
    {
        console.log("jsonLoaderCheckpoint");
        var request = new XMLHttpRequest();
        var request_url = GV.serverUrl +"/get/dishes?" + GV.loginInfo;
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

    //TODO: complete Method tableLoader
    function tableLoader(response){
        console.log("tableLoaderCheckpoint");
        var dataBase = JSON.parse(response);

        var count = 0;

        console.log("Started adding new dish into ListView");

        for (var index = 0; index < dataBase.res.length; index++)
        {
            if (dataBase.res[index].tags[0] === GV.tag){


                console.log("-------------------------------------");

                GV.dataBaseofIds[count] = dataBase.res[index].id;
                console.log("ID of new element: " + GV.dataBaseofIds[count]);

                GV.array[GV.dataBaseofIds[count]] = 0;

                GV.dataBaseofTitles[GV.dataBaseofIds[count]] = (dataBase.res[index].title).toString();
                console.log("TITLE of new element: " + GV.dataBaseofTitles[GV.dataBaseofIds[count]]);

                GV.dataBaseofPrices[GV.dataBaseofIds[count]] = dataBase.res[index].cost;
                console.log("PRICE of new element: " + GV.dataBaseofPrices[GV.dataBaseofIds[count]]);

                addButton(GV.dataBaseofIds[count]);
                count++;
            }
        }
        console.log("-------------------------------------");
        GV.count = count;
        console.log("ADDING DISHES COMPLETE! Among of new dishes: " + GV.count + ".");
        tableSize(count);
    }

    function tableSize(count){
        GV.count = count;
        var firstSide = count;
        var secondSide = 1;
        // console.log(firstSide);
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

        console.log("-----------------------------------------");
        console.log("List view can be build with this params: ");
        console.log("1. " + GV.firstSide + " 2. " + GV.secondSide);
        console.log("-----------------------------------------");
        if (firstSide < secondSide) {var swap = firstSide; firstSide = secondSide; secondSide = firstSide;}
    }

    function addButton(index){
            listModel.append({idshnik: GV.dataBaseofTitles[index]})
            console.log("NEW BUTTON WAS ADDED! TITLE IS " + GV.dataBaseofTitles[index])
            number++;
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
                    //TODO: complete onClicked in ListView
                    textIndex.text = "Вы Заказали " + text
                    console.log("------------------------");
                    console.log("New Order: ");
                    addOrder(index);
                    console.log("Title of new order: " + GV.dataBaseofTitles[GV.dataBaseofIds[index]]);
                    console.log("ID of new order: " + GV.dataBaseofIds[index]);
                    console.log("Price of new order: " + GV.dataBaseofPrices[GV.dataBaseofIds[index]]);
                    //console.log("Count of new order: " + GV.array[GV.dataBaseofIds[index]]);
                    console.log("Alternative ID: " + index);
                    console.log("------------------------");
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
                text: "Тут Будет Отображен Ваш Последний Заказ!"
                font.pixelSize: indexRec.width * 0.03
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
        text: "Закончить Заказы в этой категории"
        font.pixelSize: parent.height * 0.05
        onClicked: {
            pageLoader.source = "orderAdd.qml"
            appWindow.hide();
        }
    }
}
