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
