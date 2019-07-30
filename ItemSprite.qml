import QtQuick 2.0

Item {
    id: root
    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "images/img_item.png"
    }

    SpriteSequence {
        id: upgrade1
        width: 84
        height: 52
        visible: false
        running: false
        sprites: upgradeSprite1
    }

    Sprite {
        id: upgradeSprite1
        name: "upgrade1"
        source: imgModule.source
        frameCount: 1
        frameWidth: 80
        frameHeight: 52
        frameX: 128
        frameY: 81
        frameRate: 10
    }

    PathAnimation {
        id: upBullet1Ani
        target: root
        duration: 8000
        path: Path {
            PathLine {
                relativeX: 0;
                relativeY: parent.height
            }
        }
    }

    function createUpgrade1() {
        upgrade1.visible = true
        root.width = upgrade1.width
        root.height = upgrade1.height
        upBullet1Ani.start()
    }

    function deleteItem() {
        destroy()
    }
}
