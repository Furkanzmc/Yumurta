import QtQuick 2.7
import "../js/Utils.js" as Utils

Item {

    // ----- Public Properties ----- //

    property int radius: 25
    property real cookedPercent: 0.0
    property bool swinging: false

    // ----- Private Properties ----- //

    readonly property color _softBoiledColor: "#FFCC34"
    readonly property real _yellowRadius: root.radius * 0.8
    readonly property point _dropOnePos: Qt.point(root.width * 0.45, root.height * 0.53 + root._yellowRadius)
    readonly property point _dropTwoPos: Qt.point(root.width * 0.5, root.height * 0.53 + root._yellowRadius)

    id: root
    width: radius * 4
    height: width
    transform: Rotation {
        id: trRotation
        origin {
            x: root.width / 2
            y: root.height
        }
    }
    onCookedPercentChanged: {
        if (cookedPercent <= 0.3) {
            root._showDrops();
        }
        else {
            root._hideDrops();
        }

        canvas.requestPaint();
    }
    scale: root.swinging ? 0.6 : 1

    Behavior on scale { NumberAnimation { duration: 300 } }

    Canvas {
        anchors.fill: parent
        antialiasing: true
        onPaint: {
            var context = getContext('2d');
            _drawEggWhite(context);
        }
    }

    EggDrop {
        id: dropOne
        height: SH.dp(20)
        x: _dropOnePos.x
        y: _dropOnePos.y
    }

    EggDrop {
        id: dropTwo
        height: SH.dp(15)
        x: _dropTwoPos.x
        y: _dropTwoPos.y
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        smooth: true
        antialiasing: true
        onPaint: {
            var context = getContext('2d');
            _drawEggYellow(context);
        }
    }

    SequentialAnimation {
        id: swingStopAnimation

        NumberAnimation {
            target: trRotation; property: "angle"; from: trRotation.angle; to: 0; duration: 250
        }
    }

    SequentialAnimation {
        id: swingAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: trRotation; property: "angle"; from: 0; to: 25; duration: 250
        }

        NumberAnimation {
            target: trRotation; property: "angle"; from: 25; to: 0; duration: 250
        }

        NumberAnimation {
            target: trRotation; property: "angle"; from: 0; to: -25; duration: 250
        }

        NumberAnimation {
            target: trRotation; property: "angle"; from: -25; to: 0; duration: 250
        }
    }

    Timer {
        id: swingTimer
        interval: 300
        onTriggered: {
            swingAnimation.start();
        }
    }

    // ----- Public Functions ----- //

    function startSwinging() {
        root.swinging = true;
        swingTimer.start();
    }

    function stopSwinging() {
        root.swinging = false;
        swingAnimation.stop();
        swingStopAnimation.start();
    }

    // ----- Private Functions ----- //

    function _drawEggWhite(context) {
        var centerX = 0;
        var centerY = 0;

        context.save();
        // Translate context
        context.translate(width / 2, height / 2);

        // Scale context
        context.scale(1.2, 1.6);

        // Draw circle which will be stretched into an oval
        context.beginPath();
        context.arc(centerX, centerY, root.radius, 0, 2 * Math.PI, false);

        // Restore to original state
        context.restore();

        // Apply styling
        context.fillStyle = '#F5F5F5';
        context.fill();
    }

    function _drawEggYellow(context) {
        var centerX = 0;
        var centerY = 0;

        context.save();
        // Translate context
        context.translate(width / 2, height * 0.53);

        // Scale context
        context.scale(1.05, 1.1);

        // Draw circle which will be stretched into an oval
        context.beginPath();
        context.arc(centerX, centerY, root._yellowRadius, 0, 2 * Math.PI, false);

        // Restore to original state
        context.restore();

        // Apply styling
        // Cooked: 204
        // Un-cooked: 165
        var g = Utils.mapTo(root.cookedPercent, 0, 1, 204, 165, true);
        context.fillStyle = "rgba(255, " + parseInt(g) + ", 52, 1)";
        context.fill();
    }

    function _showDrops() {
        dropOne.x = _dropOnePos.x;
        dropOne.y = _dropOnePos.y;

        dropTwo.x = _dropTwoPos.x;
        dropTwo.y = _dropTwoPos.y;
    }

    function _hideDrops() {
        if (dropOne.y === _dropOnePos.y) {
            dropOne.y -= dropOne.height;
        }

        if (dropTwo.y === _dropTwoPos.y) {
            dropTwo.y -= dropTwo.height;
        }
    }
}
