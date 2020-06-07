import QtQuick 2.0

Rectangle {
    id: startmenu

    ColorAnimation on color {
        id: st_coloranim
        from: "white"
        to: "#171717"
        duration: 800
        loops: 1        
    }

    Text {
        id: st_text
        color: "#09f029"

        text: qsTr("KeyIt!")
        font.italic: true
        font.bold: true
        font.pixelSize: w.height / 4
        x: (w.width  / 2) - (st_text.width  / 2)
        y: (w.height / 2) - (st_text.height / 2)
        font.family: "Courier"
        horizontalAlignment: Text.AlignHCenter
    }
}
