import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4

Window {
    id: ed

    maximumHeight: 360
    maximumWidth: 1250
    minimumHeight: 360
    minimumWidth: 1250

    property string key: tools.key
    property int hue: tools.hue
    property int sat: tools.sat
    property int br: tools.br
    property int ai: tools.ai

    x: 50
    y: 450

    Rectangle {
        id: backgr
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

    function init(){
        bg_color.running = true
        monitors.f_alpha = "file:../ReKey/template.jpg"
        monitors.f_source = "file:../ReKey/template.jpg"
    }       

    function load_image() {       
        monitors.f_alpha = ""
        monitors.f_source = ""
        monitors.f_alpha = "file:/home/ermvov/Docs/bos2/lab11/ReKey/image_alpha.jpg"
        monitors.f_source = "file:/home/ermvov/Docs/bos2/lab11/ReKey/image.jpg"
        //console.log(qsTr(monitors.f_source))
    }

    visible: true
    title: qsTr("Editor")

    Monitors {
        id: monitors
    }

    Sliders {
        id: sliders
    }

    Tools {
        id: tools
        onExit: ed.visible = false
        onPrerender: {
            //console.log(qsTr(tools.key))
            onPrerender: helper.prerender(tools.key,
                                          tools.hue,
                                          tools.sat,
                                          tools.br,
                                          tools.ai,
                                          sliders.ctime,)
            load_image()
            //console.log(sliders.ctime)
        }        
    }


}
