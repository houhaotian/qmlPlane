import QtQuick 2.0

Item {
    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "qrc:/images/img_plane_enemy.png"
    }

    SpriteSequence {
        id: enemy
        width: 105
        height: 78
        visible: true
        sprites: [
            Sprite {
                name: "enemy1"
                source: imgModule.source
                frameCount: 1
                frameWidth: 105
                frameHeight: 78
                frameX: 0
                frameY: 482
                frameRate: 10
            },
            Sprite {
                name: "enemy2"
                source: imgModule.source
                frameCount: 1
                frameWidth: 105
                frameHeight: 78
                frameX: 365
                frameY: 522
                frameRate: 10
            },
            Sprite {
                name: "enemy3"
                source: imgModule.source
                frameCount: 1
                frameWidth: 105
                frameHeight: 76
                frameX: 162
                frameY: 475
                frameRate: 10
            }
        ]
        running: false
    }

    //    SpriteSequence {
    //        id: enemy1
    //        width: 105
    //        height: 78
    //        visible: false
    //        sprites: Sprite {
    //            name: "enemy1"
    //            source: imgModule.source
    //            frameCount: 1
    //            frameWidth: 105
    //            frameHeight: 78
    //            frameX: 0
    //            frameY: 482
    //            frameRate: 10
    //        }
    //        running: false
    //    }

    //    SpriteSequence {
    //        id: enemy2
    //        width: 108
    //        height: 78
    //        visible: false
    //        sprites: Sprite {
    //            name: "enemy2"
    //            source: imgModule.source
    //            frameCount: 1
    //            frameWidth: 105
    //            frameHeight: 78
    //            frameX: 365
    //            frameY: 522
    //            frameRate: 10
    //        }
    //        running: false
    //    }

    //    SpriteSequence {
    //        id: enemy3
    //        width: 105
    //        height: 76
    //        visible: false
    //        sprites: Sprite {
    //            name: "enemy3"
    //            source: imgModule.source
    //            frameCount: 1
    //            frameWidth: 105
    //            frameHeight: 76
    //            frameX: 162
    //            frameY: 475
    //            frameRate: 10
    //        }
    //        running: false
    //    }
    function createEnemy(index) {
        if (index === undefined)
            index = Math.ceil(Math.random() * 2)
        switch (index) {
        case 1:
            //    enemy1.visible = true
            enemy.jumpTo("enemy1")
            break
        case 2:
            //   enemy2.visible = true
            enemy.jumpTo("enemy2")
            break
        case 3:
            //   enemy3.visible = true
            enemy.jumpTo("enemy3")
            break
        default:
            enemy0.visible = true
        }
    }
    Component.onCompleted: {
        createEnemy()
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

