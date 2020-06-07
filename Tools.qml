import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.3


Item {

    signal exit()
    signal prerender()

    property string key: colordialog.color
    property int hue: hue.value
    property int sat: saturation.value
    property int br: lightnes.value
    property int ai: smooth.value

    Button {
            id: ext
            implicitWidth: 170
            implicitHeight: 30

            x: 1050
            y: 300+25

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5
            }


            Text {
                anchors.fill: parent
                text: "Hide"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0cfe00"
                font.italic: true
                font.pixelSize: 20
                font.family: "Arial"
            }

            onReleased: exit()
        }

    Button {
            id: prerndr
            implicitWidth: 170
            implicitHeight: 30

            x: 1050
            y: 250+25+15

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5
            }


            Text {
                anchors.fill: parent
                text: "Preview"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0cfe00"
                font.italic: true
                font.pixelSize: 20
                font.family: "Arial"
            }

            onReleased: prerender()
        }

    Button {
            id: colorset
            implicitWidth: 170
            implicitHeight: 30

            x: 1050
            y: 200+25+30

            background: Rectangle {
                anchors.fill: parent
                color: parent.pressed ? "#101010" : "#303030"
                border.color: "#0cfe00"
                border.width: 1
                radius: 5
            }


            Text {
                anchors.fill: parent
                text: "Set color key"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0cfe00"
                font.italic: true
                font.bold: true
                font.pixelSize: 20
                font.family: "Arial"
            }

            onReleased: colordialog.visible = true
        }

    Slider {
        id: hue
        x: 1050
        y: 30

        from: 0
        value: 0
        to: 359

        snapMode: "SnapOnRelease"

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitHeight: 4
            implicitWidth: 170
            width: parent.availableWidth
            height: 4
            radius: 2
            color: "#bdbebf"

            Rectangle {
                width: hue.visualPosition * parent.width
                height: parent.height
                color: "#09f029"
                radius: 2
            }
        }

        handle: Rectangle {

            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 14
            implicitHeight: 14
            radius: 2
            rotation: 45
            color: hue.pressed ? "#252525" : "#404040"
            border.color: "#09f029"

        }
    }

    Text {
        id: hue_handle
        x: 1050
        y: 10
        text: qsTr("Hue")
        font.pixelSize: 18
        font.family: "Courier"
        font.italic: true
        color: "#09f029"
    }

    Slider {
        id: saturation
        x: 1050
        y: 30 + 60

        from: 0
        value: 0
        to: 100

        snapMode: "SnapOnRelease"

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitHeight: 4
            implicitWidth: 170
            width: parent.availableWidth
            height: 4
            radius: 2
            color: "#bdbebf"

            Rectangle {
                width: saturation.visualPosition * parent.width
                height: parent.height
                color: "#09f029"
                radius: 2
            }
        }

        handle: Rectangle {

            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 14
            implicitHeight: 14
            radius: 2
            rotation: 45
            color: saturation.pressed ? "#252525" : "#404040"
            border.color: "#09f029"

        }
    }

    Text {
        id: saturation_handle
        x: 1050
        y: 10 + 60
        text: qsTr("Saturation")
        font.pixelSize: 18
        font.family: "Courier"
        font.italic: true
        color: "#09f029"
    }

    Slider {
        id: lightnes
        x: 1050
        y: 30 + 120

        from: 0
        value: 0
        to: 100

        snapMode: "SnapOnRelease"

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitHeight: 4
            implicitWidth: 170
            width: parent.availableWidth
            height: 4
            radius: 2
            color: "#bdbebf"

            Rectangle {
                width: lightnes.visualPosition * parent.width
                height: parent.height
                color: "#09f029"
                radius: 2
            }
        }

        handle: Rectangle {

            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 14
            implicitHeight: 14
            radius: 2
            rotation: 45
            color: lightnes.pressed ? "#252525" : "#404040"
            border.color: "#09f029"

        }
    }

    Text {
        id: lightnes_handle
        x: 1050
        y: 10 + 120
        text: qsTr("Lightnes")
        font.pixelSize: 18
        font.family: "Courier"
        font.italic: true
        color: "#09f029"
    }

    Slider {
        id: smooth
        x: 1050
        y: 30 + 120 + 60

        from: 0
        value: 0
        to: 100

        snapMode: "SnapOnRelease"

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitHeight: 4
            implicitWidth: 170
            width: parent.availableWidth
            height: 4
            radius: 2
            color: "#bdbebf"

            Rectangle {
                width: smooth.visualPosition * parent.width
                height: parent.height
                color: "#09f029"
                radius: 2
            }
        }

        handle: Rectangle {

            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 14
            implicitHeight: 14
            radius: 2
            rotation: 45
            color: smooth.pressed ? "#252525" : "#404040"
            border.color: "#09f029"

        }
    }

    Text {
        id: smooth_handle
        x: 1050
        y: 10 + 120 + 60
        text: qsTr("Anti-aliasing ")
        font.pixelSize: 18
        font.family: "Courier"
        font.italic: true
        color: "#09f029"
    }

    ColorDialog {
        id: colordialog
        title: "Color"
        color: "#18da2c"
        onAccepted: {
            key = color
        }

        visible: false
    }

}
