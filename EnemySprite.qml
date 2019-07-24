import QtQuick 2.12
import "logical.js" as Logic

Item {
    id: enemy

    width: 105
    height: 75
    scale: 0.7
    property int life: 1
    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "qrc:/images/img_plane_enemy.png"
    }

    //    SpriteSequence {
    //        id: enemy
    //        width: 105
    //        height: 78
    //        visible: true
    //        sprites: [
    //            Sprite {
    //                name: "enemy1"
    //                source: imgModule.source
    //                frameCount: 1
    //                frameWidth: 105
    //                frameHeight: 78
    //                frameX: 0
    //                frameY: 482
    //                frameRate: 10
    //            },
    //            Sprite {
    //                name: "enemy2"
    //                source: imgModule.source
    //                frameCount: 1
    //                frameWidth: 105
    //                frameHeight: 78
    //                frameX: 365
    //                frameY: 522
    //                frameRate: 10
    //            },
    //            Sprite {
    //                name: "enemy3"
    //                source: imgModule.source
    //                frameCount: 1
    //                frameWidth: 105
    //                frameHeight: 76
    //                frameX: 162
    //                frameY: 475
    //                frameRate: 10
    //            }
    //        ]
    //        running: false
    //    }
    SpriteSequence {
        id: enemy1
        width: 105
        height: 78
        visible: true
        sprites: Sprite {
            name: "enemy1"
            source: imgModule.source
            frameCount: 1
            frameWidth: 105
            frameHeight: 78
            frameX: 0
            frameY: 482
            frameRate: 10
        }
        running: false
    }

    SpriteSequence {
        id: enemy2
        width: 108
        height: 78
        visible: false
        sprites: Sprite {
            name: "enemy2"
            source: imgModule.source
            frameCount: 1
            frameWidth: 105
            frameHeight: 78
            frameX: 365
            frameY: 522
            frameRate: 10
        }
        running: false
    }

    SpriteSequence {
        id: enemy3
        width: 105
        height: 76
        visible: false
        sprites: Sprite {
            name: "enemy3"
            source: imgModule.source
            frameCount: 1
            frameWidth: 105
            frameHeight: 76
            frameX: 162
            frameY: 475
            frameRate: 10
        }
        running: false
    }

    //    NumberAnimation on y {
    //        from: 0
    //        to: parent.height + width
    //        duration: 4000
    //        easing.type: Easing.InOutCubic
    //        easing.amplitude: 2.0
    //        easing.period: 1.5
    //    }
    PathAnimation {
        id: pathAni
        target: enemy
        duration: 8000
        path: Path {
            PathLine {relativeX: 0; relativeY: parent.height }
          //  PathMove {relativeX: 0; relativeY: parent.height }
        }

        easing.type: Easing.InOutCubic
        easing.amplitude: 2.0
        easing.period: 1.5
    }

    function createEnemy(index) {
        if (index === undefined)
            index = Math.ceil(Math.random() * 3)
        switch (index) {
        case 1:
            enemy1.visible = true
            life = 5
            //  enemy.jumpTo("enemy1")
            break
        case 2:
            enemy2.visible = true
            life = 5
            //   enemy.jumpTo("enemy2")
            break
        case 3:
            enemy3.visible = true
            life = 5
            //  enemy.jumpTo("enemy3")
            break
        default:
            enemy0.visible = true
        }
    }

    function die(inlife = 1) {
        life-=inlife
        if(life <= 0) {
            destroy(30)
            return true
        }
        return false
    }

    Component.onCompleted: {
        createEnemy()
        pathAni.start()
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

