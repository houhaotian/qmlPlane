import QtQuick 2.0

Item {
    width: 35 * 5
    height: 30
    Row {
        anchors.fill: parent
        spacing: 5
        Repeater {
            id: rpt
            model: canvas.hero.lives
            delegate: Image {
                id: img
                width: 30
                height: 30
                source: "qrc:/images/lifeLogo.png"
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

