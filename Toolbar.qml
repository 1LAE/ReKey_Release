import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.3



Item {
    id: tb

    signal render()
    signal setKey()
    signal quitApp()

    property bool loaded: false


    Button {
            id: load
            implicitWidth: 170
            implicitHeight: 40
            visible: true            

            property bool loaded: false

            x: 10
            y: 250

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5
            }


            Text {
                anchors.fill: parent
                text: "Load Source"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0cfe00"
                font.italic: true
                font.pixelSize: 20
                font.family: "Arial"
            }
            onReleased: {                
                openFile.visible = true
            }
        }

    Button {
            id: set
            implicitWidth: 170
            implicitHeight: 40
            visible: true
            enabled: loaded ? true : false
            opacity: loaded ? 1 : 0.4

            x: 270
            y: 250

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5
            }


            Text {
                anchors.fill: parent
                text: "SetKey"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0cfe00"
                font.italic: true
                font.pixelSize: 20
                font.family: "Arial"
            }
            onReleased: setKey()
        }


    Button {
            id: quit
            implicitWidth: 170
            implicitHeight: 40

            x: 535
            y: 250

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5
            }


            Text {
                anchors.fill: parent
                text: "Quit"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0cfe00"
                font.italic: true
                font.pixelSize: 20
                font.family: "Arial"
            }

            onReleased: quitApp()
        }

    Button {
        id: rndr
        width: 200
        height: 45
        x: parent.height / 2 + width / 2
        y: 3

        enabled: loaded ? true : false
        opacity: loaded ? 1 : 0.4

        background: Rectangle {
            anchors.fill: parent
            color: parent.pressed ? "#101010" : "#303030"
            border.color: "#0cfe00"
            border.width: 1
            radius: 5
        }


        Text {
            anchors.fill: parent
            text: "RENDER!"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#0cfe00"
            font.italic: true
            font.bold: true
            font.pixelSize: 40
            font.family: "Arial"
        }

        onReleased: render()
    }


    Window {
        id: openFile
        width: 300
        height: 100
        x: 400
        y: 300
        title: "Open file"
        visible: false

        Rectangle {
            id: bg
            anchors.fill: parent
            color: "#1d1d1d"
        }

        TextField {
            id: tf
            x: parent.width / 2 - width / 2
            y: 20            
            placeholderText: "Enter absolute file path"
            //text: ""
            text: ""
            width: 270
            height: 30

        }

        Button {
            id: bt
            width: 150
            height: 30
            x: parent.width / 2 - width / 2
            y: 60          

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5

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

            onReleased: {
                openFile.close()
                tb.loaded = helper.load(qsTr(tf.text))
            }
        }
    }
}
