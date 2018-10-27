import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as C1
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: editOrder
    visible: false
    width: screen.width
    height: screen.height
    minimumHeight: screen.height
    minimumWidth: screen.width
    maximumHeight: screen.height
    maximumWidth: screen.width
    title: qsTr("Edit Orders");

    Loader{
        id: pageLoader
    }

    function menuJsonLoader(){
        var request = new XMLHttpRequest();
        var request_url = "http://api." + GV.serverUrl + ":5000/get/dishes";
        var get_request = "GET";
        var post_request = "POST";
        request.open(get_request, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4 && request.status === 200)
            {
                dataBaseOfDishesLoader(request.responseText);
                console.log("Starting menu Parsing");
            }
        }
        request.send();
    }

    function dataBaseOfDishesLoader(response){
        var dataBase = JSON.parse(response);
        console.log("Edinorog");
        for (var index = 0; index < dataBase.res.length; index++)
        {
            GV.dataBaseofTitles[dataBase.res[index].id] = dataBase.res[index].title.toString();
            GV.dataBaseofPrices[dataBase.res[index].id] = dataBase.res[index].cost;
            //GV.dataBaseofTags[dataBase.res[index].id] = dataBase.res[index].tags[0].toString();
           console.log(dataBase.res[index].id);
           console.log(GV.dataBaseofTitles[index+1] + " Added");
            console.log(GV.dataBaseofPrices[index+1] + " COST");
            //console.log(GV.dataBaseofTags[index+1] + " TAG");
        }
    }

    function makeOrder(id, among){
        GV.array[id] = among;
        GV.arrayTitle[id] = GV.dataBaseofTitles[id];
        console.log("Titel: " + GV.arrayTitle[id]);
        GV.arrayPrice[id] = GV.dataBaseofPrices[id] * GV.array[id];
        console.log ("Among: " + GV.array[id]);
        if (GV.arrayLength <= id) {GV.arrayLength = id+1;}
        console.log("ID: " + id);
        console.log("GV.arrayLength: " + GV.arrayLength);
    }

    function orderJsonLoader(){
        var request = new XMLHttpRequest();
        var request_url = "http://api." + GV.serverUrl + ":5000/get/orders";
        var get_request = "GET";
        var post_request = "POST";
        request.open(get_request, request_url, true);
        request.onreadystatechange = function(){
            if (request.readyState === 4 && request.status === 200)
            {
                console.log("Starting orders Parsing...");
                orderParsing(request.responseText);
            }
        }
        request.send();
    }

    function orderParsing(response){
        var dataBase = JSON.parse(response);
        var flag = true;
            for (var indexOrder = 0; indexOrder < dataBase.res.length; indexOrder++)
            {
                if (dataBase.res[indexOrder].status === 0 && flag === true) {GV.adress = dataBase.res[indexOrder].address; console.log("Address: " + GV.adress); GV.indexOrder = dataBase.res[indexOrder].id; console.log("FOUND"); GV.phNumber = dataBase.res[indexOrder].phone;  GV.clName = dataBase.res[indexOrder].name; flag = false;} else {console.log("NOT FOUND");}
            }
             console.log("New sort of order!");
             indexOrder = GV.indexOrder-1;
            if (flag == false){
            for (var indexDish = 0; indexDish < dataBase.res[indexOrder].dishes.length; indexDish++)
            {
                console.log("Making Order!");
                makeOrder(dataBase.res[indexOrder].dishes[indexDish].id, dataBase.res[indexOrder].dishes[indexDish].number);
                console.log(dataBase.res[indexOrder].dishes[indexDish].id + " " + dataBase.res[indexOrder].dishes[indexDish].number);
                console.log(dataBase.res[indexOrder].id);
            }
        pageLoader.source = "editOrderUI.qml";
        } else {pageLoader.source = "bucketVar.qml";}
    }

    Component.onCompleted: {
        menuJsonLoader();
        orderJsonLoader();
    }
}
