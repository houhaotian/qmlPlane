.import QtQuick 2.12 as Qute
.import QtQml 2.12 as Qml

var enemy = Qt.createComponent("EnemySprite.qml")
var hero = Qt.createComponent("HeroSprite.qml")
var gameCanvas

var bullet = Qt.createComponent("BulletSprite.qml")

function newGame(canvas) {
    gameCanvas = canvas
    gameCanvas.enemies = new Array
    gameCanvas.heroBullets = new Array
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
    for (var i = 0; i < gameCanvas.enemies.length; i++) {
        var e = gameCanvas.enemies[i]
        if (isOutOfBoundry(e)) {
            gameCanvas.enemies.splice(i, 1)
            e.die()
        }       
    }
    for (var j = 0; j < gameCanvas.heroBullets.length; j++) {
        var b = gameCanvas.heroBullets[j]
        if (isOutOfBoundry(b)) {
            gameCanvas.heroBullets.splice(j, 1)
            b.destroy(350)
        }
    }
}

function createHeroBullet() {
    var h = bullet.createObject(gameCanvas, {
                                        "x": gameCanvas.hero.x + 22,
                                        "y": gameCanvas.hero.y - 20
                                    })
    var h2 = bullet.createObject(gameCanvas, {
                                    "x": gameCanvas.hero.x + 42,
                                    "y": gameCanvas.hero.y - 20
                                })
    h.createHeroBullet()
    h2.createHeroBullet()
    gameCanvas.heroBullets.push(h)
    gameCanvas.heroBullets.push(h2)

    //   h.createEnemyBullet()
    return h
}

//这么设计是因为所有sprite都能用到
function isOutOfBoundry(sprite){
    if (sprite.x < 0 || sprite.x > gameCanvas.width - sprite.width || sprite.y < 0 || sprite.y > gameCanvas.height - sprite.height)
        return true
    else
        return false
}
