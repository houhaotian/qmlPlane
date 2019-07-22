import QtQuick 2.0

Item {
    Item {
        id: img
        clip: true
        width:65
        height:74
        visible: true
        Image {
            source: "qrc:/images/ui_new_showicon_png.png"
            x:-403
            y:-285
        }
    }

    Row {
        //       anchors.left: parent.left
        //     anchors.leftMargin: 10
        x:100
        y:100
        spacing: 5
        Repeater {
            id: rep
            model: 5
            delegate: Item {
                id: a1
                clip: true
                width:65
                height:74
                visible: true
                Image {
                    source: "qrc:/images/ui_new_showicon_png.png"
                    x:-403
                    y:-285
                }
            }
        }
    }
}
