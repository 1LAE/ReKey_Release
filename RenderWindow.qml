/* Окошко, где мы видим, что идет рендер */

import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.5


Rectangle {

    signal donee()
    property bool done: false

    id: render_window

    Timer {
        id: timer
        onTriggered: {
            done = helper.render(
                         editor.key,
                         editor.hue,
                         editor.sat,
                         editor.br,
                         editor.ai
                         )
            rd_coloranim.running = true
        }
    }

    function delay(delayTime) {
            timer.interval = delayTime;
            timer.repeat = false;
            timer.start();
        }

    function init(){
        rd_coloranim.running = true
        delay(850)
    }

    ColorAnimation on color {
        id: rd_coloranim
        from: "white"
        to: "#171717"
        duration: 800
        loops: 1
    }

    Text {
        id: st_text
        color: "#09f029"

        text: done === true ? qsTr("Re Keyed!") : qsTr("Re Keying in process...")
        font.italic: true
        font.bold: true
        font.pixelSize: w.height / 5
        x: (w.width  / 2) - (st_text.width  / 2)
        y: (w.height / 2) - (st_text.height / 2)
        font.family: "Tahoma"
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: dn
        visible: done
        implicitWidth: 200
        implicitHeight: 40

        x: parent.width / 2 - width / 2
        y: 250

        enabled: done

        background: Rectangle {
            anchors.fill: parent
            color: parent.pressed ? "#101010" : "#303030"
            border.color: "#0cfe00"
            border.width: 1
            radius: 30
        }


        Text {
            anchors.fill: parent
            text: "Done"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#0cfe00"
            font.italic: true
            font.pixelSize: 20
            font.family: "Arial"
        }

        onReleased:{
            donee()
        }
    }
}



//Window {
//        id: dg

//        property bool done: false
//        signal donee()

//        maximumHeight: 150
//        maximumWidth: 400
//        minimumHeight: 150
//        minimumWidth: 400



//        x: 300
//        y: 200

//        title: qsTr("Porcessing...")

//        function init(){
//            bg_color.running = true
//        }

//        Rectangle {
//            id: bg
//            anchors.fill: parent

//            ColorAnimation on color {
//                id: bg_color
//                running: false
//                from: "white"
//                to: "#171717"
//                duration: 400
//                loops: 1
//            }

//        }


//        Button {
//                id: cnsl
//                implicitWidth: 170
//                implicitHeight: 40

//                x: parent.width / 2 - width / 2
//                y: 70

//                enabled: done

//                background: Rectangle {
//                    anchors.fill: parent
//                    color: parent.pressed ? "#101010" : "#303030"
//                    border.color: "#0cfe00"
//                    border.width: 1
//                    radius: 5
//                }


//                Text {
//                    anchors.fill: parent
//                    text: done === true ? "Done" : "Processing"
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    color: "#0cfe00"
//                    font.italic: true
//                    font.pixelSize: 20
//                    font.family: "Arial"
//                }

//                onReleased:{
//                    donee()
//                    dg.visible = false
//                }
//            }

//}
