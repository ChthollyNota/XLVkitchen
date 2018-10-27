import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 1.4 as C1
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import QtLocation 5.11
import "GlobalVariables.js" as GV

ApplicationWindow{
    id: orderTableWindow
    width: screen.width
    height: screen.height
    minimumHeight: screen.height * 0.8
    minimumWidth: screen.width * 0.8
    maximumHeight: screen.height
    maximumWidth: screen.width
    visible: true
    title: qsTr("Корзина");

    function tableLoader(){
        var count = 0;
        var totalcost = 0;
        for (var index = 0; index < GV.arrayLength; index++)
        {
            if (GV.array[index] > 0)
            {
                if (GV.array[index] > 0){
                    GV.existedArray[count] = index;
                tableView.model.append({"title": GV.arrayTitle[index], "quantity": GV.array[index].toString(), "price": GV.arrayPrice[index].toString()});
                totalcost = totalcost + GV.arrayPrice[index];
                } else {GV.existedArray[count] = index;
                    totalcost = totalcost + GV.arrayPrice[index];
                    tableView.model.append({"title": GV.arrayTitle[index], "quantity": GV.array[index].toString(), "price": GV.arrayPrice[index].toString()});}
                count++;
            }
        }
        if (count == 0) {tableView.model.append({"title": "Вы еще ничего не заказали!", "quantity": " ", "price": " "});}
        if (count > 0) {tableView.model.append({"title": " ","quantity": "Суммарная Стоимость: ", "price": totalcost.toString()})};
    }
    Component.onCompleted: {
        tableLoader();
    }

    Loader{
        id: pageLoader
    }

    C1.TableView{
        id: tableView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.2
        C1.TableViewColumn{
           id: title
           role: "title"
           title: "Название"
           width: orderTableWindow.width * 0.1
           movable: false
           resizable: false
        }

        C1.TableViewColumn{
            id: quantity
            role: "quantity"
            title: "Количество"
            width: orderTableWindow.width * 0.1;
            movable: false
            resizable: false
            
        }
        C1.TableViewColumn{
            id: price
            role: "price"
            title: "Цена"
            width: orderTableWindow.width * 0.1
            movable: false
            resizable: false
        }

        C1.TableViewColumn{
            delegate: Button{
                text: "Добавить"
                onClicked: {
                    console.log("1: " + tableView.currentRow)
                    console.log("2: " + GV.existedArray[tableView.currentRow]);
                    GV.arrayPrice[GV.existedArray[tableView.currentRow]] = GV.arrayPrice[GV.existedArray[tableView.currentRow]] / GV.array[GV.existedArray[tableView.currentRow]];
                    GV.array[GV.existedArray[tableView.currentRow]]++;
                    GV.arrayPrice[GV.existedArray[tableView.currentRow]] = GV.arrayPrice[GV.existedArray[tableView.currentRow]] * GV.array[GV.existedArray[tableView.currentRow]];
                    console.log("3: " + GV.array[GV.existedArray[tableView.currentRow]]);
                    var row = tableView.currentRow;
                    tableView.model.clear();
                    tableLoader();
                }
            }

            role: "plus"
            title: " "
            width: orderTableWindow.width * 0.08
        }
        C1.TableViewColumn{
            delegate: Button{
                text: "Удалить"
                onClicked: {
                    GV.arrayPrice[GV.existedArray[tableView.currentRow]] = GV.arrayPrice[GV.existedArray[tableView.currentRow]] / GV.array[GV.existedArray[tableView.currentRow]];
                    GV.array[GV.existedArray[tableView.currentRow]]--;
                    GV.arrayPrice[GV.existedArray[tableView.currentRow]] = GV.arrayPrice[GV.existedArray[tableView.currentRow]] * GV.array[GV.existedArray[tableView.currentRow]];
                    var row = tableView.currentRow;
                    tableView.model.clear();
                    tableLoader();
                }
            }
            width: orderTableWindow.width * 0.08
            role: "minus"
            title: " "
        }

        model: ListModel{
            id: model1
        }
    }

    Button{
        id: makeOrder
        anchors.top: tableView.bottom
        height: parent.height * 0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        Label{
            anchors.centerIn: parent
            text: qsTr("Продолжить Работу");
            font.pixelSize: parent.height * 0.5
            color: "black"
        }
        onClicked: {
            pageLoader.source = "bucketVar.qml"
            orderTableWindow.hide();
        }
    }

    Button{
        id: quitOrder
        height: parent.height * 0.099
        anchors.top: makeOrder.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Label{
            anchors.centerIn: parent
            text: qsTr("Очистить Корзину");
            font.pixelSize: parent.height * 0.5
            color: "black"
        }
        onClicked: {
            pageLoader.source = "homePage.qml";
            GV.wipeOrderData();
            orderTableWindow.hide();
        }
    }

}
