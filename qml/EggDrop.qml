import QtQuick 2.7

Rectangle {
    id: root
    width: SH.dp(4)
    color: "#FFCC34"

    Rectangle {
        id: rectDotTwo
        width: SH.dp(10)
        height: width
        radius: width
        x: root.width * 0.5 * -1.25
        y: root.height - height * 0.4
        color: "#FFCC34"
    }

    Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }
}
