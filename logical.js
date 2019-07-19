.import QtQuick 2.12 as Qute
.import QtQml 2.12 as Qml

var enemy = Qt.createComponent("EnemySprite.qml")
var hero = Qt.createComponent("HeroSprite.qml")
var gameCanvas

var heroBullet = Qt.createComponent("BulletSprite.qml")

function newGame(canvas) {
    gameCanvas = canvas
    gameCanvas.enemies = new Array
}

function createHero() {
    var h = hero.createObject(gameCanvas, {
                          "x": 217,
                          "y": 563
                      })
    return h
}

function createEnemy() {
    var Cox = Math.ceil(Math.random() * gameCanvas.width)
    var e = enemy.createObject(gameCanvas, {
                                   "x": Cox,
                                   "y": 0
                               })
    gameCanvas.enemies.push(e)
    return e
}

function timerTask() {
    createEnemy()

    for (var i = 0; i < gameCanvas.enemies.length; i++) {
        var e = gameCanvas.enemies[i]
        if (e.isOutOfBoundry()) {
            gameCanvas.enemies.splice(i, 1)
            e.die()
        }
    }
}

function createBullet() {
   var h = heroBullet.createObject(gameCanvas, {
                                "x": 0,
                                "y": 0
                            })
    return h
}
