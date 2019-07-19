import QtQuick 2.12

Item {
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
        width: 24
        height: 81
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

    function createHeroBullet(){
        heroBullet.visible = true
        heroBulletAni.start()
    }

    function createEnemyBullet(){
        enemyBullet.visible = true
    }

    NumberAnimation on y{
        id: heroBulletAni
        running: false
        duration: 1200
        to: 0 - heroBullet.height
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

