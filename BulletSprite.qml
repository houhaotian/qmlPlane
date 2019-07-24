import QtQuick 2.0

Item {
    id: root
    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "images/img_bullet.png"
    }

    SpriteSequence {
        id: heroBullet
        width: 15
        height: 25
        visible: false
        running: false
        sprites: hero
    }

    Sprite {
        id: hero
        name: "heroBullet"
        source: imgModule.source
        frameCount: 1
        frameWidth: 25
        frameHeight: 36
        frameX: 733
        frameY: 676
        frameRate: 10
    }

    SpriteSequence {
        id: enemyBullet
        width: 15
        height: 15
        visible: false
        running: false
        sprites: enemey1
    }

    Sprite {
        id: enemey1
        name: "enemyBullet1"
        source: imgModule.source
        frameCount: 1
        frameWidth: 22
        frameHeight: 36
        frameX: 334
        frameY: 171
        frameRate: 10
    }

    NumberAnimation on y {
        id: heroBulletAni
        running: false
        duration: 3000
        to: -parent.height
    }

//    ParallelAnimation {
//        id: enemyBulletAni
//        running: false
//        alwaysRunToEnd: true
//        NumberAnimation {
//            id: enemyBulletAniX
//            target: root
//            property: "x"
//            duration: 3000
//        }
//        NumberAnimation {
//            id: enemyBulletAniY
//            target: root
//            property: "y"
//            duration: 3000
//        }
//    }

    PathAnimation {
        id: enemyBulletAni
        target: root
        duration: 4000
        path: Path {
            PathLine {
                relativeX: 0;
                relativeY: parent.height
            }
          //  PathMove {relativeX: 0; relativeY: parent.height }
        }

//        easing.type: Easing.InOutCubic
//        easing.amplitude: 2.0
//        easing.period: 1.5
    }


    function createHeroBullet() {
        heroBullet.visible = true
        root.width = heroBullet.width
        root.height = heroBullet.height
        heroBulletAni.start()
    }

    function createEnemyBullet(heroX, heroY) {
        enemyBullet.visible = true
        root.width = enemyBullet.width
        root.height = enemyBullet.height
        enemyBulletAni.start()
    }
}




/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
