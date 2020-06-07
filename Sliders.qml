import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

    property int ctime: slider.value

    Slider {
        id: slider
        x: 10
        y: 285

        from: 0
        value: 50
        to: 100

        snapMode: "SnapOnRelease"
        onMoved: ctime = value
        onValueChanged: ctime = value

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitHeight: 10
            implicitWidth: 1000 - 20
            width: parent.availableWidth
            height: 20
            radius: 2
            color: "#bdbebf"

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                color: "#09f029"
                radius: 2
            }
        }

        handle: Rectangle {

            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 5
            implicitHeight: 22
            radius: 2
            color: slider.pressed ? "#252525" : "#404040"
            border.color: "#09f029"

            Text {
                id: slider_time
                visible: false
                anchors.centerIn: parent
                text: ctime.toString()
                color: "#09f029"
            }
        }
    }

    GridLayout{

        id: gl
        x: 18
        y: slider.y + 30
        rows: 2
        columns: 31
        columnSpacing: 31

        Repeater {
            id: timeline
            model: parent.columns

            Rectangle {
                width: 1
                height: 17
                color: "#09f029"
                radius: 1
            }
        }
    }

    GridLayout{

        id: gll
        x: 34
        y: slider.y + 30
        rows: 2
        columns: 30
        columnSpacing: 31

        Repeater {
            id: tm
            model: parent.columns

            Rectangle {
                width: 1
                height: 10
                color: "#09f029"
                radius: 1
            }
        }
    }
}
