import QtQuick 2.12
import QtQml 2.12
import "logical.js" as Logic

Item {
    id: canvas
    property var hero
    property var enemies
    property var heroBullets

    //主任务
    Timer{
        interval: 1000
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
    //创建英雄子弹
    Timer{
        id:heroBulletCreate
        interval: 500
        repeat: true
        running: false
        onTriggered: {
            Logic.createHeroBullet()
        }
    }

    function createHeroBullet(){
        heroBulletCreate.running = true
    }

    Component.onCompleted: {
        Logic.newGame(canvas)
        hero = Logic.createHero()
        createHeroBullet()
    }
}
