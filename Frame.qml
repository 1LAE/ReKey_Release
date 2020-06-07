import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: img


    property string src
    property string title: ""


    Rectangle {
        id: backgr
        width: 500
        height: 280
        color: "#222222"
    }

    Image {
        id: image
        x: 250 - image.width / 2
        y: 140 - image.height / 2
        source: src
        cache: false
    }



    Rectangle {
        id: txt_bg
        width: 70
        height: 20
        color: "black"
        border.color: "#09f029"
        border.width: 1
        radius: 3
        opacity: 0.4

        Text {
            id: text
            anchors.centerIn: parent
            text: title
            color: "#09f029"
            font.pixelSize: 14
        }
    }

}



