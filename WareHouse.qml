import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV
ApplicationWindow {
    id: warehouseTables
    visible: true
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("WareHouse")

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
        anchors.topMargin: parent.height * 0.08
        flickableDirection: Flickable.AutoFlickDirection
        model: model
        delegate: Text {
            text: listdata
            scale: 1
            fontSizeMode: Text.Fit
            font.pixelSize: warehouseTables.height * 0.04
        }
    }

        function jsonLoader()
        {
            console.log("jsonLoaderCheckpoint");
            var request = new XMLHttpRequest();
            var request_url = "http://api." + GV.serverUrl + ":5000/get/ingredients";
            var get_request = "GET";
            var post_request ="POST";
            request.open(post_request, request_url, true);
            request.onreadystatechange = function(){
                if (request.readyState === 4)
                {
                    var status = request.status;
                    if (request.status === 200) {
                        jsonIngredientsLoader(request.responseText);
                    }
                }
            };
            request.send();
        }

        function jsonIngredientsLoader(response)
        {
            console.log("Checkpoint");
            var request = new XMLHttpRequest();
            var request_url = "http://api.torianik.online:5000/get/goods";
            var get_request = "GET";
            var post_request = "POST";
            request.open(post_request, request_url, true);
            request.onreadystatechange = function(){
                if (request.readyState === 4)
                {
                    var status = request.status;
                    if (request.status === 200)
                    {
                        tableLoader(response, request.responseText);
                    }
                }
            }

        }

        function tableLoader(response, ingResponse){
            console.log("tableLoaderCheckpoint");
            var dataBase = JSON.parse(response);
            for (var index = 0; index < dataBase.res.length; index++) {
                var id = (dataBase.res[index].id);
                var title = (dataBase.res[index].title);
                var expiry = (dataBase.res[index].expiry);
                listView.model.append({listdata: id + ". " + title + ". Expiry: " + expiry + "."})
            }
        }

    Button{
        id: getData
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.1
        anchors.margins: parent.width * 0.05
        text: "Get Data"
        font.pixelSize: parent.height * 0.05
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
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom:parent.bottom
        height: parent.height * 0.1
        anchors.margins: parent.width * 0.05
        text: "Back to Main Menu"
        font.pixelSize: parent.height * 0.05
        onClicked:
        {
            pageLoader.source = ("homePage.qml");
            warehouseTables.hide();
        }

    }

    Text {
        id: text1
        text: qsTr("WAREHOUSE LIST:")
        anchors.fill: parent
        font.pixelSize: parent.height * 0.06
    }
//}
}

/*##^## Designer {
    D{i:5;anchors_y:0;anchors_x:0;anchors_height:26;anchors_width:480}
}
 ##^##*/
