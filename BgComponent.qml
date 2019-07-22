import QtQuick 2.0

Rectangle {
    id: bgComponent
    width: 512
    height: 768

    Image {
        id: bg
        x: 0
        y: 0
        source: "images/img_bg_level_1.jpg"
        fillMode: Image.PreserveAspectFit

        SequentialAnimation on y {
            loops: Animation.Infinite
            running: true
            PropertyAnimation {
                to: y + parent.height
                duration: 5000
            }
            PropertyAnimation {
                to: y - parent.height
                duration: 0
            }
        }
    }
    Image {
        id: bg2
        x: 0
        y: -parent.height
        source: "images/img_bg_level_1.jpg"
        fillMode: Image.PreserveAspectFit

        SequentialAnimation on y {
            loops: Animation.Infinite
            running: true
            PropertyAnimation {
                to: y
                duration: 5000
            }
            PropertyAnimation {
                to: y - parent.height
                duration: 0
            }
        }
    }
}
