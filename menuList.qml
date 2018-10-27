import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow {
    id: menuTables
    visible: true
    width: screen.width
  //  minimumHeight: screen.height * 0.94
  //  minimumWidth: screen.width * 0.94
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Меню")

  Loader {
      id: pageLoader
  }
  ListModel {
        id: model
    }
    ListView {
        id: listView
        width: parent.width
        height: parent.height
        anchors.bottom: quitButton.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.09
        anchors.bottomMargin: parent.height * 0.03
        flickableDirection: Flickable.AutoFlickDirection
        model: model
         delegate : Text {
            text: listdata
            scale: 1
            fontSizeMode: Text.Fit
            font.pixelSize: menuTables.height * 0.04
        }
    }

        function jsonLoader()
        {
            console.log("jsonLoaderCheckpoint");
            var request = new XMLHttpRequest();
            var request_url = "http://api." + GV.serverUrl + ":5000/get/dishes";
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
            for (var index = 0; index < dataBase.res.length; index++) {
                var length = dataBase.res.length;
                if (dataBase.res[index].is_visible) {
                    var yes = "yes";
                    var no = "no";
                    var fav;
                    if (dataBase.res[index].is_favourite) {fav = yes.toString();} else {fav = no.toString();}
                    var title = (dataBase.res[index].title).toString();
                    var cost = (dataBase.res[index].cost).toString();
                    var mass = (dataBase.res[index].cost).toString();
                    listView.model.append({listdata: "Название: " + title + ". " + cost + " Гривен." + " Вес: " + mass + "g."})
                    if (fav === "yes") {fav = "да";} else {fav = "нет";}
                    listView.model.append({listdata: dataBase.res[index].describe + "Пользуется ли спросом: " + fav + "."})
                    listView.model.append({listdata: " "})
                    listView.model.append({listdata: " "})
                }
            }
        }

    Button{
        id: getData
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: menuTables.height * 0.1
        text: "Загрузить Меню На Сегодня"
        font.pixelSize: menuTables.height * 0.05
        onClicked:
        {
            jsonLoader();
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
        height: menuTables.height * 0.1

        text: "Вернуться В Главное Меню"
        font.pixelSize: menuTables.height * 0.05
        onClicked:
        {
            console.log(GV.login);
            console.log(GV.token);
            console.log(GV.arrayLength);
            menuTables.hide();
            pageLoader.source = ("homePage.qml");
        }

    }

    Text {
        id: text1
        text: qsTr("Меню:")
        anchors.fill: parent
        font.pixelSize: parent.height * 0.06
    }
  }

/*##^## Designer {
    D{i:5;anchors_y:0;anchors_x:0;anchors_height:26;anchors_width:480}
}
 ##^##*/
