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
    }

    ListModel {
           id: stickModel
    }

    Rectangle{
        width: 40
        height: 40
        Layout.alignment: Qt.AlignCenter
        color: "lightgrey"
        id: rectangleUp
        Text {
            horizontalAlignment:  Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            anchors.fill:parent
            text: "+"
            font.pixelSize: 20
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (stickModel.count < 5)
                    stickModel.insert(stickModel.count,{})
            }
            onPressed: {
                rectangleUp.color = "grey"
            }
            onReleased: {
                rectangleUp.color = "lightgrey"
            }
        }
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
        color: "lightgrey"
        id: rectangleDown
        Text {
            horizontalAlignment:  Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            anchors.fill:parent
            text: "-"
            font.pixelSize: 20
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (stickModel.count > 1)
                    stickModel.remove(stickModel.count-1)
            }
            onPressed: {
                rectangleDown.color = "grey"
            }
            onReleased: {
                rectangleDown.color = "lightgrey"
            }
        }
    }
}
