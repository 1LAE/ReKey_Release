import QtQuick 2.0

Item {

    property string f_source
    property string f_alpha

    Frame {
            id: source
            title: "source"
            src: f_source
        }

    Frame {
            x: 500
            id: alpha
            title: "alpha"
            src: f_alpha
        }
}
