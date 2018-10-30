import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "GlobalVariables.js" as GV

ApplicationWindow {
    id: orderAddWindow
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr ("Order Add")
    function jsonLoader()
    {
        var request = new XMLHttpRequest();
        var request_url = GV.serverUrl + "/get/dishes?" + GV.loginInfo;
        var request_get = "GET"
        request.open(request_get, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState == 4)
            {
                if (request.status == 200){
                dataBaseOfTagsLoader(request.responseText);
                } else {console.log("Error... Aborting!");}

            }
        }
        request.send();
    }
    function dataBaseOfTagsLoader(response){
        if (GV.parseFlag === true){
            var dataBase = JSON.parse(response);
            var tagsCount = 0;
            for (var index = 0; index < dataBase.res.length; index++)
            {
                //console.log("Starting JSON parsing...");
                var flag = true;
                for (var tagIndex = 0; tagIndex <= tagsCount; tagIndex++)
                {
                    //console.log((dataBase.res[index].tags[0]).toString());
                    if ((dataBase.res[index].tags[0]).toString() === GV.dataBaseofTags[tagIndex] && flag == true)
                    {
                        //console.log("New element wasn't found...");
                        flag = false;
                    }
               }
                if (flag === true){
                    GV.dataBaseofTags[tagsCount] = (dataBase.res[index].tags[0]).toString();
                    console.log("DATABASE OF TAGS NEW ELEM: " + (GV.dataBaseofTags[tagsCount]));
                    tagsCount++;
                }
            }
            console.log("Count of all dishes: " + GV.arrayLength);
            console.log("Parsing was completed! " + tagsCount + " of new elements found!");
            console.log("TITLES ARE: ");
            for (index = 0; index < tagsCount; index++)
            {
                console.log("------------");
                console.log(GV.dataBaseofTags[index]);
                console.log("------------");
                GV.parseFlag = false;
            }
        }
        addButton();

    }

    function addButton(){
        for (var index = 0; index < GV.dataBaseofTags.length; index++)
        {
            var text = GV.dataBaseofTags[index];
            if (text === "first_course") {text = "Первое Блюдо"}
            if (text === "nonalcoholic_beverage") {text = "Безалкогольные Напитки"}
            if (text === "acloholic_beverage") {text = "Алкогольные Напитки"}
            if (text === "dessert") {text = "Десерт"}
            if (text === "salad") {text = "Салат"}
            if (text === "main_course") {text = "Главное Блюдо"}
            if (text === "snack") {text = "Закуски"}
            listModel.append({idshnik: text})
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
            height: (orderAddWindow.height * 0.2)

            Button {
                anchors.fill: parent
                anchors.margins: parent.height * 0.1


                text: idshnik
                font.pixelSize: orderAddWindow.height * 0.05


                onClicked: {
                    textIndex.text = "Вы выбрали категорию " + text
                    GV.tag = GV.dataBaseofTags[index];
                    pageLoader.source = "DishCreator.qml";
                    orderAddWindow.hide();
                    console.log("INDEX IN FUNC: " + GV.dataBaseofTags[index] + " INDEX: " + index);
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
            width: (orderAddWindow.width)
            height: orderAddWindow.height * 0.1

            Text {
                id: textIndex
                anchors.fill: indexRec
                text: "Выбирайте свою категорию!"
                font.pixelSize: indexRec.width * 0.05
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    Button{
        id: quitButton
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.10
        font.pixelSize: parent.height * 0.05
        text: qsTr("Выйти в Главное Меню");
        onClicked: {
            pageLoader.source = "homePage.qml";
            orderAddWindow.hide();
        }
    }
}
