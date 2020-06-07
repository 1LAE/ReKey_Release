import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.5

Window {
        id: dg

        property bool done: false
        signal donee()

        maximumHeight: 150
        maximumWidth: 400
        minimumHeight: 150
        minimumWidth: 400



        x: 300
        y: 200

        title: qsTr("Porcessing...")

        function init(){
            bg_color.running = true
        }

        Rectangle {
            id: bg
            anchors.fill: parent

            ColorAnimation on color {
                id: bg_color
                running: false
                from: "white"
                to: "#171717"
                duration: 400
                loops: 1
            }

        }       


        Button {
                id: cnsl
                implicitWidth: 170
                implicitHeight: 40

                x: parent.width / 2 - width / 2
                y: 70

                enabled: done

                background: Rectangle {
                    anchors.fill: parent
                    color: parent.pressed ? "#101010" : "#303030"
                    border.color: "#0cfe00"
                    border.width: 1
                    radius: 5
                }


                Text {
                    anchors.fill: parent
                    text: done === true ? "Done" : "Processing"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "#0cfe00"
                    font.italic: true
                    font.pixelSize: 20
                    font.family: "Arial"
                }

                onReleased:{
                    donee()
                    dg.visible = false
                }
            }

}
