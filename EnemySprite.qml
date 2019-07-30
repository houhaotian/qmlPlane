import QtQuick 2.12
import "logical.js" as Logic

Item {
    id: enemy
    scale: 0.7
    property int life: 1

    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "qrc:/images/img_plane_enemy.png"
    }

    SpriteSequence {
        id: enemy1
        width: 105
        height: 78
        visible: false
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

    SpriteSequence {
        id: enemyBonus
        width: 182
        height: 138
        visible: false
        sprites: Sprite {
            name: "enemyBonus"
            source: imgModule.source
            frameCount: 1
            frameWidth: 180
            frameHeight: 135
            frameX: 187
            frameY: 339
            frameRate: 10
        }
        running: false
    }

    PathAnimation {
        id: pathAni
        target: enemy
        duration: 8000
        path: Path {
            PathLine {relativeX: 0; relativeY: parent.height }
        }

        easing.type: Easing.InOutCubic
        easing.amplitude: 2.0
        easing.period: 1.5
    }

    function createEnemy(level) {
        if(level!==undefined)
            setEnemyLife(level)

        let index = Math.ceil(Math.random() * 3)

        switch (index) {
        case 1:
            enemy1.visible = true
            enemy.width = enemy1.width
            enemy.height = enemy1.height
            break
        case 2:
            enemy2.visible = true
            enemy.width = enemy2.width
            enemy.height = enemy2.height
            break
        case 3:
            enemy3.visible = true
            enemy.width = enemy3.width
            enemy.height = enemy3.height
            break
        default:
            enemy0.visible = true
        }

        pathAni.start()
    }

    function createBonusPlane() {
        setEnemyLife(10)
        enemyBonus.visible = true
        enemy.width = enemyBonus.width
        enemy.height = enemyBonus.height
        pathAni.start()
    }

    function setEnemyLife(setLife) {
        life = setLife
    }

    //返回值：0->没死，1->死了，2->bonus飞机死了
    //如果killLife是undefined，直接销毁
    function die(killLife) {
        if(killLife === undefined)
            life = 0
        else
            life -= killLife

        if(life <= 0) {
            destroy()
            if(enemyBonus.visible === true) {
                return 2
            }
            return 1
        }
        return 0
    }
}
