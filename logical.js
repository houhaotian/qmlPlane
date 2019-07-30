.import QtQuick 2.0 as Qute
.import QtQml 2.0 as Qml

var enemy = Qt.createComponent("EnemySprite.qml")
var hero = Qt.createComponent("HeroSprite.qml")
var gameCanvas

var bullet = Qt.createComponent("BulletSprite.qml")
var upgrade = Qt.createComponent("ItemSprite.qml")

var heroBulletLevel = 0

function newGame(canvas) {
    gameCanvas = canvas
    gameCanvas.enemies = new Array
    gameCanvas.heroBullets = new Array
    gameCanvas.enemyBullets = new Array
    gameCanvas.items = new Array
}

function createHero() {
    let h = hero.createObject(gameCanvas, {
                          "x": 217,
                          "y": 563
                      })
    return h
}

function createEnemy(level) {
    let Cox = Math.ceil(Math.random() * gameCanvas.width)
    let e = enemy.createObject(gameCanvas, {
                                   "x": Cox,
                                   "y": 10
                               })
    e.createEnemy(level)
    gameCanvas.enemies.push(e)
    return e
}

function createBonusPlane() {
    let Cox = Math.ceil(Math.random() * gameCanvas.width)
    let e = enemy.createObject(gameCanvas, {
                                   "x": Cox,
                                   "y": 10
                               })
    e.createBonusPlane()
    gameCanvas.enemies.push(e)
    return e
}

function createUpgrade(x, y) {
    let item1 = upgrade.createObject(gameCanvas,{
                             "x": x,
                             "y": y
                         })
    item1.createUpgrade1()
    gameCanvas.items.push(item1)
}

function createBoss1() {
    let boss1 = enemy.createObject(gameCanvas, {
                                   "x": gameCanvas.width / 2,
                                   "y": 10
                               })
    boss1.createBoss1()
    gameCanvas.enemies.push(boss1)
    return boss1
}

function killhero(killLife = 1) {
    gameCanvas.hero.lives -= killLife
    if(gameCanvas.hero.lives <= 0){
        console.log("gameOver!")
        gameCanvas.stopGame()
        return //gameOver
    }
}

function timerTask() {
    //轮询英雄子弹
    for (let j in gameCanvas.heroBullets) {
        let b = gameCanvas.heroBullets[j]
        //销毁子弹,出界销毁延时350，提升性能
        if (isOutOfBoundry(b)) {
            gameCanvas.heroBullets.splice(j, 1)
            b.destroy(350)
        }
        //子弹击中敌机时，销毁each
        //创建bonus
        for (let i in gameCanvas.enemies) {
            let e = gameCanvas.enemies[i]
            if (isCollided(b, e)) {
                gameCanvas.heroBullets.splice(j, 1)
                b.destroy()
                let x = e.x, y = e.y
                let isBounus = e.die(1)
                if(isBounus)
                    gameCanvas.enemies.splice(i, 1)
                if(isBounus === 2)
                    createUpgrade(x, y)
            }
        }
    }

    for (let i in gameCanvas.enemyBullets) {
        let b = gameCanvas.enemyBullets[i]
        //销毁子弹,出界销毁延时350，提升性能
        if (isOutOfBoundry(b)) {
            gameCanvas.enemyBullets.splice(i, 1)
            b.destroy(350)
        }
        if (isCollided(b, gameCanvas.hero)) {
            gameCanvas.enemyBullets.splice(i, 1)
            b.destroy()
            killhero()
        }
    }

    //再轮询敌机,处理敌机出界，与英雄碰撞情况
    //如将此次轮询放上面会导致英雄被频繁销毁
    //故暂且放在这再查询一遍
    for (let i in gameCanvas.enemies) {
        let e = gameCanvas.enemies[i]
        if (isOutOfBoundry(e)) {
            gameCanvas.enemies.splice(i, 1)
            e.die()
        }
        if (isCollided(gameCanvas.hero, e)) {
            if(e.die(gameCanvas.hero.life))
                 gameCanvas.enemies.splice(i, 1)
            killhero(e.life)
        }
    }

    //处理item
    for(let i in gameCanvas.items) {
        let item1 = gameCanvas.items[i]
        if(isOutOfBoundry(item1)){
            item1.deleteItem()
            gameCanvas.items.slice(i, 1)
        }
        if(isCollided(gameCanvas.hero, item1)) {
            item1.deleteItem()
            gameCanvas.items.slice(i, 1)
            ++heroBulletLevel
        }
    }
}

function createHeroBullet() {
    switch(heroBulletLevel)
    {
    case 0:
        let b = bullet.createObject(gameCanvas, {
                                        "x": gameCanvas.hero.x + 32,
                                        "y": gameCanvas.hero.y - 20
                                    })
        b.createHeroBullet()
        gameCanvas.heroBullets.push(b)
        break
    case 1:
        let b1 = bullet.createObject(gameCanvas, {
                                        "x": gameCanvas.hero.x + 22,
                                        "y": gameCanvas.hero.y - 20
                                    })
        let b2 = bullet.createObject(gameCanvas, {
                                         "x": gameCanvas.hero.x + 42,
                                         "y": gameCanvas.hero.y - 20
                                     })
        b1.createHeroBullet()
        b2.createHeroBullet()
        gameCanvas.heroBullets.push(b1)
        gameCanvas.heroBullets.push(b2)
        break
    case 2:
        break
    default:
        return
    }
}

function createEnemyBullet(e) {
    let b = bullet.createObject(gameCanvas, {
                                    "x": e.x + 45,
                                    "y": e.y + 45
                                })
    b.createEnemyBullet(gameCanvas.hero.x, gameCanvas.hero.y)
    gameCanvas.enemyBullets.push(b)
    return b
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
