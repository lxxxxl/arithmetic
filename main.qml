import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQml 2.1
import QtMultimedia 5.1

import ttswrapper 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("arithmetic")
    id: mainWindow

    TTSWrapper{
        id: tts

        function say_how_much(){
            var saystr = qsTr("Сколько будет ")
            saystr += stickControl1.getStickCount().toString() + action.text + stickControl2.getStickCount().toString()
            tts.say(saystr)
        }
    }

    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min; //max is not included, min is included
    }

    ColumnLayout{
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter

        Component.onCompleted: function(){
            stickControl1.setStickCount(getRandomInt(1,3));
            stickControl2.setStickCount(getRandomInt(1,6));
        }


        RowLayout{
            Layout.preferredWidth: mainWindow.width
            spacing: 5
            StickControl{
                id: stickControl1
            }

            Text{
                text: "+"
                font.bold: true
                font.pixelSize: 50
                id: action
            }

            StickControl{
                id: stickControl2
            }

            Text{
                text: "="
                font.bold: true
                font.pixelSize: 50
            }

            Rectangle{
                width: 70
                height: 130
                color: "lightgrey"
                Text{
                    anchors.centerIn: parent
                    text: "?"
                    font.bold: true
                    font.pixelSize: 100
                    color: "red"
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        tts.say_how_much()
                    }
                    onPressed: {
                        parent.color = "grey"
                    }
                    onReleased: {
                        parent.color = "lightgrey"
                    }
                }
            }
        }

        RowLayout{
            // empty row
            Layout.preferredHeight: 30
        }

        RowLayout{
            spacing: 50
            width: parent.width
            Layout.alignment: Qt.AlignCenter
            SpinBox{
                from: 1
                to: 10
                font.pixelSize: 30
                id: result
            }

            Rectangle{
                width: imageOk.width
                height: imageOk.height

                Image {
                    source: "images/ok.png"
                    Layout.alignment: Qt.AlignCenter
                    id: imageOk
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: function(){
                        tts.say(result.value)
                        showResultTimer.start()
                    }
                    onPressed: {
                        parent.color = "lightgrey"
                    }
                    onReleased: {
                        parent.color = "white"
                    }
                }
                Timer {
                       interval: 1000; running: false; repeat: false
                       id: showResultTimer
                       onTriggered: {
                           if (stickControl1.getStickCount() + stickControl2.getStickCount() == result.value){
                               playSound.source = "/sounds/ok.wav"
                               imageGoodResult.visible = true
                               stickControl1.setStickCount(getRandomInt(1,3));
                               stickControl2.setStickCount(getRandomInt(1,6));
                           }
                           else{
                               playSound.source = "qrc:/sounds/no.wav"
                               imageBadResult.visible = true
                           }
                           hideResultTimer.start()
                       }
                       function start(){
                           showResultTimer.interval = 1000
                           showResultTimer.running = true
                       }
                }
                Timer {
                       interval: 1000; running: false; repeat: false
                       id: hideResultTimer
                       onTriggered: {
                           imageBadResult.visible = false
                           imageGoodResult.visible = false
                       }
                       function start(){
                           playSound.play()
                           hideResultTimer.interval = 1000
                           hideResultTimer.running = true
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
        fillMode: Image.PreserveAspectFit
        visible: false
        id: imageBadResult
    }
    Image {
        source: "images/good_big.png"
        anchors.fill: parent
        verticalAlignment: Image.AlignVCenter
        horizontalAlignment: Image.AlignHCenter
        fillMode: Image.PreserveAspectFit
        visible: false
        id: imageGoodResult

        onVisibleChanged: {
                if (!visible)
                    tts.say_how_much()
        }

    }
}
