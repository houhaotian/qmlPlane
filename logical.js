.import QtQuick 2.12 as Qute
.import QtQml 2.12 as Qml

var enemy = Qt.createComponent("EnemySprite.qml")
var hero = Qt.createComponent("HeroSprite.qml")
var gameCanvas

function newGame(canvas) {
    gameCanvas = canvas
    gameCanvas.enemies = new Array()
}

function createHero() {
    hero.createObject(gameCanvas, {
                          "x": 217,
                          "y": 563
                      })
}

function createEnemy() {

    var Cox = Math.ceil(Math.random() * gameCanvas.width)// - enemy.width
    enemy.createObject(gameCanvas,{
                        //   "x":Cox,
                        //   "y":0
                       })


    gameCanvas.enemies.push(enemy)
}

function timerTask() {
    createEnemy()
}
