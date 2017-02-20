import QtQuick 2.7

Rectangle {

    // ----- Public Properties ----- //

    property bool stopEnabled: false

    // ----- Signals ----- //

    signal clicked()

    id: root
    radius: SH.dp(5)
    color: "#F5F5F5"

    Text {
        id: lbTitle
        text: root.stopEnabled ? qsTr("STOP") : qsTr("GET COOKIN'!")
        font.pixelSize: parent.height * 0.5
        anchors.centerIn: parent
        color: "#010101"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked();
        }
    }
}
