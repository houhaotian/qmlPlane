import QtQuick 2.12
import QtQml 2.12
import "logical.js" as Logic

Item {
    id: canvas
    property var hero
    property var enemies

    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {
            Logic.timerTask()
        }
    }

    Component.onCompleted: {
        Logic.newGame(canvas)
        Logic.createHero()
    }
}
