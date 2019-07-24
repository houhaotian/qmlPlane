import QtQuick 2.0
import QtQml 2.0
import "logical.js" as Logic

Item {
    id: canvas
    property var hero
    property var enemies
    property var heroBullets
    property var enemyBullets
    signal gameFailed

    //主任务
    Timer {
        id: mainLoop
        interval: 100
        repeat: true
        running: false
        onTriggered: {
            Logic.timerTask()
        }
    }
    //创建敌机
    Timer {
        id: createETimer
        interval: 500
        repeat: true
        running: false
        onTriggered: {
            var e = Logic.createEnemy()
        }
    }

    //因为js文件每次import都是一个实例，而子弹需要设置canvas为父类
    //因此发射子弹全都放在canvas组件中。虽然有些不和情理，但放在各自精灵中暂时不好实现。
    //缺点可能是所有敌机发射子弹都是同时的。。。

    //发射敌机子弹
    Timer {
        id: createEBullet
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            enemies.forEach(function (element) {
                Logic.createEnemyBullet(element)
            })
        }
    }

    //创建英雄子弹
    Timer {
        id: heroBulletCreate
        interval: 200
        repeat: true
        running: false
        onTriggered: {
            Logic.createHeroBullet()
        }
    }

    function startNewGame() {
        mainLoop.start()
        createETimer.start()
        createEBullet.start()
        hero.x = 217
        hero.y = 563
        hero.lives = 5
        heroBulletCreate.running = true
    }

    function stopGame() {
        mainLoop.stop()
        createETimer.stop()
        createEBullet.stop()
        heroBulletCreate.running = false
        destroyAllElement()
        gameFailed()
    }

    function destroyAllElement() {
        while(enemies.length > 0) {
            enemies.pop().destroy()
        }
        while(heroBullets.length > 0) {
            heroBullets.pop().destroy()
        }
        while(enemyBullets.length > 0) {
            enemyBullets.pop().destroy()
        }
    }

    Component.onCompleted: {
        Logic.newGame(canvas)
        hero = Logic.createHero()
    }
}
