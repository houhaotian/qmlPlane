import QtQuick 2.0

Item {
    visible: true
    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "images/img_plane_main.png"
    }

    SpriteSequence {
        id: hero
        width: 80 //sprite的size可能要根据具体模型动态改变
        height: 65
        interpolate: false
        running: false
        sprites: [
            Sprite {
                name: "hero1"
                source: imgModule.source
                frameCount: 3
                frameWidth: 120
                frameHeight: 98
                frameX: 394
                frameRate: 10
            }
        ]
    }
    focus: true
    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Up:
            if (hero.y <= 0)
                break
            hero.y -= 10
            break
        case Qt.Key_Down:
            if (hero.y >= parent.height - hero.height)
                break
            hero.y += 10
            break
        case Qt.Key_Left:
            if (hero.x <= 0)
                break
            hero.x -= 10
            break
        case Qt.Key_Right:
            if (hero.x >= parent.width - hero.width)
                break
            hero.x += 10
            break
        default:
            return
        }
    }
    Keys.onReleased: hero.running = false

    property int lives: 4

    Component.onCompleted: lives = 0
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

