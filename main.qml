import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQml 2.1

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("arithmetic")
    id: mainWindow



    ColumnLayout{
        spacing: 10
        Layout.preferredWidth: mainWindow.width
        RowLayout{
            // empty row
            Layout.preferredHeight: 20
        }

        RowLayout{
            Layout.preferredWidth: mainWindow.width
            spacing: 5
            StickControl{
                id: stickControl1
            }
            Text{
                anchors.verticalCenter: parent
                text: "+"
                font.bold: true
                font.pixelSize: 40
            }
            StickControl{
                id: stickControl2
            }
            Text{
                anchors.verticalCenter: parent
                text: "="
                font.bold: true
                font.pixelSize: 40
            }
            Text{
                anchors.verticalCenter: parent
                text: "?"
                font.bold: true
                font.pixelSize: 80
            }

        }

        RowLayout{
            // empty row
            Layout.preferredHeight: 20
        }

        RowLayout{
            spacing: 30
            width: parent.width
            Layout.alignment: Qt.AlignCenter
            SpinBox{
                from: 1
                to: 10
                font.pixelSize: 20
                id: result

            }

            Image {
                source: "images/ok.png"
                Layout.alignment: Qt.AlignCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: function(){
                                showResultTimer.running = true
                                if (stickControl1.stickCount + stickControl2.stickCount == result.value)
                                    imageGoodResult.visible = true
                                else
                                    imageBadResult.visible = true



                    }
                }
                Timer {
                       interval: 1000; running: false; repeat: true
                       id: showResultTimer
                       onTriggered: {
                           imageBadResult.visible = false
                           imageGoodResult.visible = false
                       }
                   }
            }

        }
    }


    Image {
        source: "images/bad_big.png"
        anchors.fill: parent
        verticalAlignment: Image.AlignVCenter
        horizontalAlignment: Image.AlignHCenter
        visible: false
        id: imageBadResult

    }
    Image {
        source: "images/good_big.png"
        anchors.fill: parent
        verticalAlignment: Image.AlignVCenter
        horizontalAlignment: Image.AlignHCenter
        visible: false
        id: imageGoodResult

    }
}
