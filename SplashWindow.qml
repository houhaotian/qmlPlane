import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: rectangle
    width: 512
    height: 768
    signal startNewGame
    Image {
        id: img1
        anchors.fill: parent
        source: "images/mainWindow.jpg"
    }

    Text {
        id: gameover
        x: 69
        y: 239
        width: 374
        height: 108
        color: "#f2f2f2"
        text: qsTr("GAME OVER!!!")
        visible: false
        style: Text.Sunken
        font.weight: Font.DemiBold
        font.capitalization: Font.AllUppercase
        font.italic: true
        font.bold: true
        styleColor: "#572828"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 51
    }

    Button {
        id: buttonStart
        x: 137
        y: 540
        width: 238
        height: 54
        text: qsTr("开始游戏")
        focusPolicy: Qt.ClickFocus
        onClicked: startNewGame()
    }

    Loader {
        id: loadAbout
        source: "AboutWindow.qml"
        anchors.centerIn: parent
        visible: false
    }

    Button {
        id: buttonAbout
        x: 137
        y: 645
        width: 238
        height: 54
        text: qsTr("关于")
        property bool isShow: false
        onClicked: {
            isShow = !isShow
            loadAbout.visible = isShow
        }
    }

    Image {
        id: img2
        x: 0
        y: 0
        width: 512
        height: 123
        source: "images/LOGO.png"
    }

    states: [
        State {
            name: "gameFailed"
            // when:
            PropertyChanges {
                target: rectangle
                color: "gray"
            }
        },
        State {
            name: "default"
        }
    ]

    transitions: Transition {
        ColorAnimation {
            duration: 3000
        }
    }

    function showFailedSplash() {
        state = "gameFailed"
        img1.visible = false
        img2.visible = false
        gameover.visible = true
    }
}

/*##^## Designer {
    D{i:1;anchors_height:149;anchors_width:512;anchors_x:0;anchors_y:0}D{i:5;anchors_height:149;anchors_width:231;anchors_x:141;anchors_y:0}
}
 ##^##*/

