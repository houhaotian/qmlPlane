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
        property real xx: 0
        property real yy: 0

        width: 80 //sprite的size可能要根据具体模型动态改变
        height: 65
        interpolate: false
        running: false
        focus: true

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

    Keys.onPressed: {
        //        console.log(hero.x, hero.y)
        switch (event.key) {
        case Qt.Key_Up:
            if (hero.yy <= 0)
                break
            hero.y -= 10
            hero.yy -= 10
            break
        case Qt.Key_Down:
            if (hero.yy >= parent.height - hero.height)
                break
            hero.yy += 10
            hero.y += 10
            break
        case Qt.Key_Left:
            if (hero.xx <= 0)
                break
            hero.xx -= 10
            hero.x -= 10
            break
        case Qt.Key_Right:
            if (hero.xx >= parent.width - hero.width)
                break
            hero.xx += 10
            hero.x += 10
            break
        default:
            return
        }
    }
    Keys.onReleased: hero.running = false

    property int lives: 0

    Component.onCompleted: {
        lives = 4

        var point = hero.mapToItem(parent, 0, 0)
        hero.xx = point.x
        hero.yy = point.y
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

