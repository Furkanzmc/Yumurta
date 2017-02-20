import QtQuick 2.7

Loader {
    id: root

    Component {
        id: refreshComponent

        Text {
            text: "Refresh"
            font.pointSize: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    QM.reload();
                }
            }
        }
    }

    // ----- Public Functions ----- //

    function show() {
        if (Qt.platform.os === "windows" || Qt.platform.os === "osx" || Qt.platform.os === "unix") {
            QM.setWindow(mainWindow);
            root.sourceComponent = refreshComponent;
        }
        else {
            console.log("[Error] RefreshButton: Cannot enable RefreshButton in a mobile build.");
        }
    }
}
