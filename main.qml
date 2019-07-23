/**************************************************************
*   main.qml中放置了GameCanvas类。
*   所有精灵都在GameCanvas类中管理。
*   GameCanvas本身是覆盖window上层的。可当做一个layer
*   判断逻辑尽量写在logical.js中
*
*
*
*
**************************************************************/
import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: root

    visible: true
    width: 512
    height: 768
    title: qsTr("Hello World")
    maximumWidth: 512
    maximumHeight: 768
    minimumWidth: 512
    minimumHeight: 768

    BgComponent {
        id: bg
        z:0
    }

    LifeBar{
        id: lifeBar
        z:0
    }

    GameCanvas {
        id: canvas
        anchors.fill: parent
        z:2
    }
}

/*##^## Designer {
    D{i:1;anchors_height:100;anchors_width:100;anchors_x:228;anchors_y:181}D{i:3;anchors_height:141;anchors_width:248;anchors_x:154;anchors_y:475}
}
 ##^##*/

