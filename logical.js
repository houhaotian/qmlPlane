.import QtQuick 2.0 as Qute
.import QtQml 2.0 as Qml

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

function killhero(){
    gameCanvas.hero.lives -= 1
    if(gameCanvas.hero.lives <= 0){
        console.log("gameOver!")
        return //gameOver
    }
}

function timerTask() {
    //轮询英雄子弹
    for (var j = 0; j < gameCanvas.heroBullets.length; j++) {
        var b = gameCanvas.heroBullets[j]
        //销毁子弹,出界销毁延时350，提升性能
        if (isOutOfBoundry(b)) {
            gameCanvas.heroBullets.splice(j, 1)
            b.destroy(350)
        }
        //子弹击中敌机时，销毁each
        for (var i = 0; i < gameCanvas.enemies.length; i++) {
            var e = gameCanvas.enemies[i]
            if (isCollided(b, e)) {
                gameCanvas.heroBullets.splice(j, 1)
                b.destroy()
                gameCanvas.enemies.splice(i, 1)
                e.die()
            }
        }
    }
    //再轮询敌机,处理敌机出界，与英雄碰撞情况
    //如将此次轮询放上面会导致英雄被频繁销毁
    //故暂且放在这再查询一遍
    for (var i = 0; i < gameCanvas.enemies.length; i++) {
        var e = gameCanvas.enemies[i]
        if (isOutOfBoundry(e)) {
            gameCanvas.enemies.splice(i, 1)
            e.die(350)
        }
        if (isCollided(gameCanvas.hero, e)) {
            e.die()
            killhero()
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

//碰撞检测。研究BOX2d
function isCollided(sprite1, sprite2) {
    if((sprite1.x <= sprite2.x && (sprite1.x + sprite1.width >=sprite2.x)) &&(sprite1.y<=sprite2.y && sprite1.y+sprite1.width>=sprite2.y))
        return true;
    else if((sprite2.x <= sprite1.x && (sprite2.x + sprite2.width >=sprite1.x)) &&(sprite2.y<=sprite1.y && sprite2.y+sprite2.width>=sprite1.y))
        return true;
    else
        return false;
}
