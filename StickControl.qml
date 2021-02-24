import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ColumnLayout{
    id: stickLayout
    spacing: 2
    width: 100
    property int stickCount: stickModel.count

    ListModel {
           id: stickModel
           ListElement {}
       }

    Text {
        Layout.alignment: Qt.AlignCenter
        text: "+"
        font.bold: true
        width: parent.width
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (stickModel.count < 5)
                    stickModel.insert(stickModel.count,{})
            }
        }
    }

    Row {
        anchors.centerIn: parent
        Repeater {
            model: stickModel
            Image   {
                source: "images/stick.png"
            }
        }

    }

    Text {
        Layout.alignment: Qt.AlignCenter
        text: "-"
        font.bold: true
        width: parent.width
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (stickModel.count > 1)
                    stickModel.remove(stickModel.count-1)
            }
        }
    }
}
