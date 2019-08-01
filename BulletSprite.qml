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

    //向上运动
    NumberAnimation on y {
        id: heroBulletAni0
        running: false
        duration: 3000
        to: -parent.height
    }

    //左斜向上60度
    PathAnimation {
        id: heroBulletAni1
        target: root
        running: false
        duration: 3000
        path: Path {
            PathLine {
                relativeX: -parent.height * Math.tan(60);
                relativeY: -parent.height
            }
        }
    }

    //右斜向上60度
    PathAnimation {
        id: heroBulletAni2
        target: root
        running: false
        duration: 3000
        path: Path {
            PathLine {
                relativeX: parent.height * Math.tan(60);
                relativeY: -parent.height
            }
        }
    }


    //左斜向上75度
    PathAnimation {
        id: heroBulletAni3
        target: root
        running: false
        duration: 3000
        path: Path {
            PathLine {
                relativeX: -parent.height * Math.tan(45);
                relativeY: -parent.height
            }
        }
    }

    //右斜向上75度
    PathAnimation {
        id: heroBulletAni4
        target: root
        running: false
        duration: 3000
        path: Path {
            PathLine {
                relativeX: parent.height * Math.tan(45);
                relativeY: -parent.height
            }
        }
    }

    PathAnimation {
        id: enemyBulletAni
        target: root
        duration: 4000
        path: Path {
            PathLine {
                relativeX: 0;
                relativeY: parent.height
            }
        }
    }

    //0向前，1左斜向上，2右斜向上
    function createHeroBullet(index) {
        heroBullet.visible = true
        root.width = heroBullet.width
        root.height = heroBullet.height

        switch(index)
        {
        case 0:
            heroBulletAni0.start()
            break
        case 1:
            heroBulletAni1.start()
            heroBullet.rotation = -30
            break
        case 2:
            heroBulletAni2.start()
            heroBullet.rotation = 30
            break
        case 3:
            heroBulletAni3.start()
            heroBullet.rotation = -45
            break
        case 4:
            heroBulletAni4.start()
            heroBullet.rotation = 45
            break
        }
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
