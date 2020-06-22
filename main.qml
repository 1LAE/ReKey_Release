/* Главный файл, отсюда вызывается все остальное */

import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.2


Window {
    id: w
    x: 100
    y: 100
    visible: true

    minimumWidth: 2.39*300
    maximumWidth: 2.39*300
    width:        2.39*300

    minimumHeight: 1*300
    maximumHeight: 1*300
    height:        1*300

    title: qsTr("ReKey")

    Startmenu {
        id: start
        anchors.fill: parent
        visible: true
    }

    Toolbar {
        id: toolbar
        anchors.fill: parent
        visible: true

        onQuitApp: Qt.quit()
        onSetKey: {
            editor.visible = true
            editor.init()
        }

        onRender: {            
            editor.visible = false
            toolbar.visible = false
            rndr_window.visible = true
            rndr_window.init()
//            rndr_window.done = true
//            rndr_window.done = helper.render(
//                        editor.key,
//                        editor.hue,
//                        editor.sat,
//                        editor.br,
//                        editor.ai
//                        )

            //console.log(editor.key, editor.hue, editor.sat, editor.br, editor.ai)

        }
    }

    Editor {
        id: editor
        visible: false      
    }

    RenderWindow {
        id: rndr_window       
        anchors.fill: parent
        visible: false
        onDonee: {
            toolbar.visible = true
            visible = false
            start.init()
        }
    }         
}
