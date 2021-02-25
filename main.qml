import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQml 2.1
import QtMultimedia 5.1

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
                                if (stickControl1.stickCount + stickControl2.stickCount == result.value){
                                    playSound.source = "/sounds/ok.wav"
                                    imageGoodResult.visible = true
                                }
                                else{
                                    playSound.source = "qrc:/sounds/no.wav"
                                    imageBadResult.visible = true
                                }
                                showResultTimer.start()



                    }
                }
                Timer {
                       interval: 1000; running: false; repeat: false
                       id: showResultTimer
                       onTriggered: {
                           imageBadResult.visible = false
                           imageGoodResult.visible = false
                       }
                       function start(){
                           playSound.play()
                           showResultTimer.interval = 1000
                           showResultTimer.running = true

                       }
                   }

                SoundEffect {
                        id: playSound
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
