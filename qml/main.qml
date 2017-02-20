import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    id: mainWindow
    visible: true
    width: 480
    height: 640
    title: "Yumurta"
    color: "#FDFDF8"
    Component.onCompleted: {
        if (QML_DEBUG) {
            refreshLoader.show();
        }
    }

    RefreshButton {
        id: refreshLoader
        anchors {
            left: parent.left
            top: parent.top
        }
    }

    TimerLabel {
        id: lbTimer
        anchors {
            top: parent.top
            topMargin: SH.dp(10)
            horizontalCenter: parent.horizontalCenter
        }
        percent: slider.percent
        onFinishedChanged: {
            if (finished) {
                egg.stopSwinging();
            }
        }
    }

    Egg {
        id: egg
        anchors.centerIn: parent
        radius: parent.width * 0.2
        focus: true
        cookedPercent: slider.percent
    }

    Slider {
        id: slider
        width: parent.width * 0.7
        height: SH.dp(2)
        anchors {
            top: egg.bottom
            topMargin: SH.dp(15)
            horizontalCenter: parent.horizontalCenter
        }
        proggress: lbTimer.progress
    }

    Button {
        id: btnStart
        width: slider.width
        height: SH.dp(35)
        anchors {
            top: slider.bottom
            topMargin: SH.dp(50)
            horizontalCenter: parent.horizontalCenter
        }
        onClicked:  {
            if (stopEnabled) {
                egg.stopSwinging();
                lbTimer.stopTimer();
                slider.percent = 0.0;
                slider.handleVisible = true;
            }
            else {
                egg.startSwinging();
                lbTimer.startTimer();
                slider.handleVisible = false;
            }
            stopEnabled = !stopEnabled;
        }
    }
}
