.pragma library
var login = "login"
var token = "token"

var array = [0];
var arrayLength = 0
var arrayPrice = [1];
var arrayTitle = ['Nothing was ordered yet!'];
var existedArray = [0];
var dataBaseofPrices = [1];

//For one Dish
var dataBaseofIds = [0];
var dataBaseofTitles = [' '];
var firstSide = 0;
var secondSide = 0;
var count = 0;
var tag = "noting";
//For categories
var dataBaseofTags = [' '];

//For user auth
var name = "Ресторан";
var phone = "Ресторанный Телефон";
//For odrer categories
var parseFlag = true;
//For WareHouse
var dataBaseOfIngrediens = [' '];
//For editOrder
var indexOrder = 0;
var phNumber = 0;
var clName = 'Укажите Имя';
var streetName = ' ';
var apsNumber = ' ';
var houseNumber = ' ';
var cityName = ' ';
//For connection
var serverUrl = "xlvzero.tk";
var flagOnEdit = false;
var adress = " ";
//For OrdersList
var indexOrderList = 0;
for (var index = 0; index <= arrayLength; index++)
{
    array[index] = 0;
}
    //for wiping order.
    function wipeOrderData(){
        for (var index = 0; index < arrayLength; index++)
        {
            array[index] = 0;
        }
        console.log("wipeComplete");
    }
//for unpressed button
var flag = true;

var status = 200;
