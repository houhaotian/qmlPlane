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
        width: 24
        height: 81
        visible: true
        running: false
        sprites: [hero, enemey1]
    }

    Sprite {
        id: hero
        name: "heroBullet"
        source: imgModule.source
        frameCount: 1
        frameWidth: 25
        frameHeight: 100
        frameX: 733
        frameY: 676
        frameRate: 10

        NumberAnimation {
            target: hero
            property: "y"
            duration: 200
            //easing.type: Easing.InOutQuad
            to: 0
        }
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

    function createBullet(){
        heroBullet.jumpTo("enemyBullet1")
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

