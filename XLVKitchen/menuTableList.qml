import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import "GlobalVariables.js" as GV

ApplicationWindow {
    title: qsTr("table grid");
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    visible: true
    id: wareHouseList
    Loader{
        id: pageLoader
    }

    C1.TableView{
        id: tableView
        frameVisible: false
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: quitButton.top
        alternatingRowColors: true
        horizontalScrollBarPolicy: -1
        sortIndicatorColumn: 1
        sortIndicatorOrder: 1
        opacity: 1
        scale: 1
        C1.TableViewColumn{
            id: titleTable
            role: "title"
            title: "Название"
            width: wareHouseList.width * 0.1
            movable: false
            resizable: true
        }

        C1.TableViewColumn{
            id: massTable
            role: "mass"
            title: "Масса"
            width: wareHouseList.width * 0.1
            movable: false
            resizable: false
        }

        C1.TableViewColumn{
            id: expiryTable
            role: "expiry"
            title: "Срок Годности"
            width: wareHouseList.width * 0.1
            movable: false
            resizable: false
        }

        C1.TableViewColumn{
            id: dateTable
            role: "date"
            title: "Дата Поступления"
            width: wareHouseList.width * 0.3
            movable: false
            resizable: false
        }

        model: ListModel{
            id: model1
        }
    }

    function dataBaseLoader()
    {
        console.log("Starting request to dataBase...");
        var request = new XMLHttpRequest();
        var request_url = GV.serverUrl +"/get/ingredients?" + GV.loginInfo;
        var get_request = "GET";
        request.open (get_request, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4 && request.status === 200)
            {
                jsonIngredientsLoader(request.responseText);
            }
        }
        request.send();
    }

    function jsonIngredientsLoader(response)
    {
        console.log("Checkpoint");
        var request = new XMLHttpRequest();
        var request_url = GV.serverUrl + "/get/goods?" + GV.loginInfo;
        var get_request = "GET";
        var post_request = "POST";
        request.open(post_request, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4)
            {
                var status = request.status;
                if (request.status === 200)
                {
                    jsonTableBuilder(response, request.responseText);
                }
            }
        }
        request.send();
    }

    function jsonTableBuilder(response, ingResponse)
    {
        console.log("Starting JSON.parse...");
        var dataBaseIngredients = JSON.parse(response);
        var dataBaseGoods = JSON.parse(ingResponse);
        console.log("Building a Table...");
        for (var index = 0; index < dataBaseGoods.res.length; index++)
        {
            var title = (dataBaseIngredients.res[dataBaseGoods.res[index].ingredient_id-1].title)
            console.log("ID: " + dataBaseGoods.res[index].id);
            console.log("TITLE: " + dataBaseIngredients.res[dataBaseGoods.res[index].ingredient_id-1].title);
            var date = (dataBaseGoods.res[index].date).toString();
            var expiry = (dataBaseIngredients.res[dataBaseGoods.res[index].ingredient_id-1].expiry);
            var mass = (dataBaseGoods.res[index].mass);

            tableView.model.append({"title" : title, "mass": mass, "expiry" : expiry + " days left", "date": date})
        }
        console.log("TableBuilding was finished. Status: " + dataBaseIngredients.status);
    }

    Button{
        id: getData
        visible: true
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.1
        text: "Получить Актуальную Информацию"
        font.pixelSize: wareHouseList.height * 0.05
        onClicked:
        {
            console.log("Started TableBuilding Process...");
            dataBaseLoader();
            getData.visible = false;
            quitButton.visible = true;
        }
    }
    Button{
        id: quitButton
        visible: false
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.1
        text: "Выйти В Главное Меню"
        font.pixelSize: wareHouseList.height * 0.05
        onClicked: {
            wareHouseList.close();
            pageLoader.source = "homePage.qml";
            console.log(tableView.rowCount);
            console.log("Navigating to MainMenu...");
        }
    }
}
