import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import "GlobalVariables.js" as GV

ApplicationWindow {
 id: authWindow
 visible: true
 width: screen.width
 height: screen.height
 minimumHeight: screen.height * 0.8
 minimumWidth: screen.width * 0.8
 maximumHeight: screen.height
 maximumWidth: screen.width
 title: qsTr("Authentication")

        Loader {
            id: pageLoader
        }
        Rectangle  {
        id: loginPg
        width: screen.width
        height: screen.height
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
                anchors.fill: parent
                anchors.margins: 3
                font.pixelSize: parent.height * 0.7
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
            text: 'Имя Пользователя'
            anchors.bottom: loginRec.top
        }
        Rectangle
        {
            id: passRec
            y: parent.height * 0.5
            height: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.1
            anchors.rightMargin: parent.width * 0.1
            anchors.left: parent.left
            anchors.right: parent.right
            border.width: 1
            border.color: "black"
            TextInput
            {
                id: passTxt
                anchors.fill: parent
                anchors.margins: 3
                echoMode: TextInput.Password
                font.pixelSize: parent.height * 0.7
                passwordMaskDelay: 1000
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
            text: 'Пароль'
            anchors.bottom: passRec.top
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

            onClicked:
            {
                console.log("clicked")
                console.log(GV.serverUrl);
                var request = new XMLHttpRequest();
                var request_url = "http://api." + GV.serverUrl + ":5000/login?login=" + loginTxt.text + "&password=" + passTxt.text;
                var get_request = "GET";
                var post_request = "POST";
                //console.log(request_url);
                request.open(get_request, request_url, true);
                request.onreadystatechange = function()
                {
                    if (request.readyState === 4 && request.status === 200){
                        var dataBase = JSON.parse(request.responseText);
                        if (dataBase.status === 200) {
                            var token = dataBase.res.token;
                            console.log(dataBase.res.token);
                            authWindow.hide();
                            pageLoader.source = "homePage.qml"
                            GV.login = loginTxt.text;
                            GV.token = token;
                        }
                        if (dataBase.status === 400) {
                            console.log(dataBase.message);
                        }

                    }
                };
                request.send();
            }
        }
    }
}
