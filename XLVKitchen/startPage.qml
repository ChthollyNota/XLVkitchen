import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow
{

    id: startWindow
    visible: true
    width: screen.width
    height: screen.height
    maximumHeight: screen.height
    maximumWidth: screen.width
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    title: qsTr("Start Page");

    Loader{
        id: pageLoader
    }

    Rectangle {
        id: loginRec
        border.width: 1
        border.color: "black"
        y: parent.height * 0.2
        height: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width * 0.1
        anchors.rightMargin: parent.width * 0.1
        TextInput
        {
            id: loginTxt
            text: GV.serverUrl
            anchors.fill: parent
            anchors.margins: 3
            font.pixelSize: parent.height * 0.7
            onTextChanged: {
                GV.serverUrl = loginTxt.text
                loginButton.text = "Войти в Систему";
                console.log("Changed");
                listModel.clear();
                jsonLoader();
            }
        }
    }
    Text
    {
        height: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width * 0.1
        anchors.rightMargin: parent.width * 0.1
        font.pixelSize: parent.height * 0.05
        text: 'Введите Aдрес Cервера'
        anchors.bottom: loginRec.top
    }

    ComboBox{
        id: comboSox
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.1
        anchors.leftMargin: parent.width * 0.1
        anchors.rightMargin: parent.width * 0.1
        y: parent.height * 0.32
        font.pixelSize: parent.height * 0.03
        textRole: "key"
            model: ListModel {
                id: listModel
                ListElement { key: "Выберите кафе"; value: 0 }
            }
            onCurrentTextChanged: {
                loginButton.text = "Войти в Систему";
            }
        }



    function jsonLoader(){
        var request = new XMLHttpRequest();
        var request_url = GV.serverUrl + "/get/cafes";
        var request_get = "GET";
        var dataBase;
        request.open(request_get, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4 && request.status === 200)
            {
                comboBoxCreator(request.responseText);
            } else {
                if (request.readyState === 4 && request.status !== 200){
                    listModel.append({key: "Не могу загрузить список кафе", value: 0});
                    comboSox.currentIndex = 0;
                    loginButton.visible = false;
                }
            }
        }
        request.send();
    }

    function comboBoxCreator(response)
    {
        var dataBase = JSON.parse(response);
        listModel.append({key: "Выберите кафе", value: 0 });
        comboSox.currentIndex = 0;
        loginButton.visible = true;
        for (var index = 0; index < dataBase.res.length; index++){
            console.log("HELLO " + index);

            listModel.append({key: dataBase.res[index].title.toString(), value: dataBase.res[index].id});
            console.log(dataBase.res[index].title.toString());
        }
    }

    Button
    {
        id: loginButton
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.1
        anchors.margins: parent.width * 0.1
        text: "Войти В Систему"
        font.pixelSize: parent.height * 0.05
        onClicked: {
            if (comboSox.currentText === "Выберите кафе") {loginButton.text = "Выберите кафе";} else {
            GV.cafe_id = comboSox.currentIndex;
            console.log(GV.cafe_id);
            GV.serverUrl = loginTxt.text;
            startWindow.visible = false;
            pageLoader.source = "authWindow.qml";
            }
        }
    }
}

