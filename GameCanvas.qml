import QtQuick 2.0
import QtQml 2.0
import "logical.js" as Logic

Item {
    id: canvas
    property var hero
    property var enemies
    property var heroBullets
    property var enemyBullets

    //主任务
    Timer{
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            Logic.timerTask()
        }
    }
    //创建敌机
    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {
            Logic.createEnemy()
        }
    }

    //因为js文件每次import都是一个实例，而子弹需要设置canvas为父类
    //因此发射子弹全都放在canvas组件中。虽然有些不和情理，但放在各自精灵中暂时不好实现。
    //缺点可能是所有敌机发射子弹都是同时的。。。

    //发射敌机子弹
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            enemies.forEach(function(element) {
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

    Component.onCompleted: {
        Logic.newGame(canvas)
        hero = Logic.createHero()
        heroBulletCreate.running = true
    }
}

