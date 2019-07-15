// Shared game state
.import QtQuick 2.12 as Qute.import QtQml 2.12 as Qml

var enemy = Qt.createComponent("EnemySprite.qml")

function createEnemy() {
    return enemy.createObject()
}
