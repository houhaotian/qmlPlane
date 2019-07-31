/*
*游戏主要控制逻辑，资源管理放在这里
*/
import QtQuick 2.0
import QtQml 2.0
import "logical.js" as Logic

Item {
    id: canvas
    property var hero
    property var enemies
    property var heroBullets
    property var enemyBullets
    property var items

    property int stage
    property int gameTime: 0 //游戏走过的时间。用来控制难度变化
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
        interval: 900
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

            if (gameTime++ > 60 && state == "level0") {
                state = "level1"
            }
            if (gameTime % 5 == 0) {
                let e = Logic.createBonusPlane()
            }
            if (gameTime == 60) {
                let boss1 = Logic.createBoss1()
            }
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
        gameTime = 0
        state = "level0"
    }

    function stopGame() {
        mainLoop.stop()
        createETimer.stop()
        createEBullet.stop()
        heroBulletCreate.running = false
        destroyAllElement()
        gameFailed()
        gameTime = 0
    }

    function destroyAllElement() {
        while (enemies.length > 0) {
            enemies.pop().destroy()
        }
        while (heroBullets.length > 0) {
            heroBullets.pop().destroy()
        }
        while (enemyBullets.length > 0) {
            enemyBullets.pop().destroy()
        }
    }

    function toTimeString() {
        var hour = Math.floor(gameTime / 3600)
        var min = Math.floor((gameTime / 60) % 60)
        var sec = gameTime - hour * 3600 - min * 60
        return "%1:%2:%3".arg(hour).arg(min).arg(sec)
    }

    states: [
        State {
            name: "level0"
            PropertyChanges {
                target: createETimer
                interval: 900
            }
            PropertyChanges {
                target: createEBullet
                interval: 1000
            }
        },
        State {
            name: "level1"
            PropertyChanges {
                target: createETimer
                interval: 750
                onTriggered: {
                    var e = Logic.createEnemy(5)
                }
            }
            PropertyChanges {
                target: createEBullet
                interval: 850
            }
        }
    ]

    Component.onCompleted: {
        Logic.newGame(canvas)
        hero = Logic.createHero()
    }
}
