import QtQuick 2.7
import "../js/Utils.js" as Utils

Rectangle {

    // ----- Public Properties ----- //

    property real percent: 0.0
    property real proggress: 0.0
    property bool handleVisible: true

    id: root
    color: "#A7A7A7"
    onPercentChanged: {
        handle.x = Utils.clamp(root.width * root.percent, -handle.width, root.width + handle.width);
    }

    Rectangle {
        id: handle
        width: root.height * 7
        height: width
        anchors.verticalCenter: parent.verticalCenter
        radius: width
        color: "#010101"
        scale: root.handleVisible ? 1 : 0

        Behavior on scale { NumberAnimation { duration: 150 } }
    }

    Text {
        text: qsTr("Soft Boiled")
        color: "#CDCDCD"
        font.pixelSize: SH.dp(15)
        anchors {
            top: parent.bottom
            topMargin: SH.dp(8)
            left: parent.left
        }
    }

    Text {
        text: qsTr("Hard Boiled")
        color: "#CDCDCD"
        font.pixelSize: SH.dp(15)
        anchors {
            top: parent.bottom
            topMargin: SH.dp(8)
            right: parent.right
        }
    }

    MouseArea {
        width: parent.width
        height: handle.height
        anchors.centerIn: parent
        visible: handle.scale > 0.95
        onMouseXChanged: {
            root.percent = Utils.clamp(mouseX / root.width, 0, 1.0);
        }
    }

    Rectangle {
        id: proggressBar
        width: root.width * root.proggress
        height: root.height
        color: "#010101"
    }
}
