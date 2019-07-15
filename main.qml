import QtQuick 2.12
import QtQuick.Window 2.12
import "logical.js" as Logic

Window {

    property var enemies

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
    }

//    HeroSprite {
//        id: hero
//        x: 217
//        y: 563
//    }

    //    EnemySprite {
    //        id: enemy
    //        x: 186
    //        y: 0
    //    }
    Component.onCompleted: {
        enemies = new Array(100)
        var hero=Qt.createComponent("HeroSprite.qml")
        hero.createObject()
        hero.x=217
        hero.y=563

    }
    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {

            //            var enemy = Logic.createEnemy()
            //            enemies.push(enemy)
            //            enemy.x=180
            //            enemy.y=0
            var enemy = Qt.createComponent("EnemySprite.qml")
            enemy.createObject()
        }
    }
}

/*##^## Designer {
    D{i:1;anchors_height:100;anchors_width:100;anchors_x:228;anchors_y:181}D{i:3;anchors_height:141;anchors_width:248;anchors_x:154;anchors_y:475}
}
 ##^##*/

