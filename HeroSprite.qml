import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id: hero
    visible: true
    width: 80 //sprite的size可能要根据具体模型动态改变
    height: 65

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
        onPositionChanged: {
            stayWhereUAre()
        }
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

    //当英雄要超出屏幕时，使其停在那
    function stayWhereUAre() {
        if (hero.y <= 0)
            hero.y = 0
        if (hero.y >= parent.height - hero.height)
            hero.y = parent.height - hero.height
        if (hero.x <= 0)
            hero.x = 0
        if (hero.x >= parent.width - hero.width)
            hero.x = parent.width - hero.width
    }

    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Left:
            hero.x -= 10
            break
        case Qt.Key_Up:
            hero.y -= 10
            break
        case Qt.Key_Right:
            hero.x += 10
            break
        case Qt.Key_Down:
            hero.y += 10
            break
        default:
            return
        }
        stayWhereUAre()
    }
    Keys.onReleased: heroSprite.running = false

    Component.onCompleted: {
        lives = 5
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

