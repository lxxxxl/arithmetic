import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQml 2.1

ColumnLayout{
    id: stickLayout
    spacing: 5
    Layout.preferredWidth: 75

    function getStickCount(){
        return stickModel.count
    }
    function setStickCount(value){
        stickModel.clear()
        for (var i = 0; i < value; i++)
            stickModel.insert(stickModel.count,{})
        rectangleCountText.text = stickModel.count
    }

    ListModel {
           id: stickModel
    }

    Row {
        Layout.alignment: Qt.AlignCenter
        Repeater {
            model: stickModel
            Image   {
                source: "images/stick.png"
            }
        }
    }

    Rectangle{
        width: 40
        height: 40
        Layout.alignment: Qt.AlignCenter
        id: rectangleCount
        Text {
            horizontalAlignment:  Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            anchors.fill:parent
            id: rectangleCountText
            text: stickModel.count
            font.pixelSize: 20
        }
    }
}
