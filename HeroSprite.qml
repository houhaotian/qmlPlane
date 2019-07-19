import QtQuick 2.0
import QtQuick.Particles 2.12

Item {
    id: hero
    visible: true
    width: 80 //sprite的size可能要根据具体模型动态改变
    height: 65
    property real xx: 0
    property real yy: 0
    //英雄属性
    property int lives: 0

    Image {
        id: imgModule
        fillMode: Image.Stretch
        visible: false
        source: "images/img_plane_main.png"
    }

    Drag.active: mouseArea.drag.active
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent
    }

    SpriteSequence {
        id: heroSprite
        interpolate: false
        running: false
        focus: true
        anchors.fill: parent
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

    ParticleSystem {
        id: particleSys

        ImageParticle {
            source: "qrc:/images/particle1.png"
            system: particleSys
            entryEffect: ImageParticle.Fade
        }
        Emitter {
            id: emitter
            x: 33
            y: hero.height + 5
            width: 2
            height: 10
            system: particleSys
            emitRate: 200
            lifeSpan: 50
            acceleration: PointDirection {
                x: 0
                y: 30
            }
        }
        Emitter {
            id: emitter2
            x: 42
            y: hero.height + 5
            width: 2
            height: 10
            system: particleSys
            emitRate: 200
            lifeSpan: 50
            acceleration: PointDirection {
                x: 0
                y: 30
            }
        }
    }


    Keys.onPressed: {
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
    Keys.onReleased: heroSprite.running = false

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

