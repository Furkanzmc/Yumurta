import QtQuick 2.7

Text {

    // ----- Public Properties ----- //

    property real percent: 0.0
    property real progress: 0.0
    property bool finished: false

    // ----- Private Properties ----- //

    // Duration is taken from here: http://www.simplyrecipes.com/recipes/how_to_make_perfect_hard_boiled_eggs/
    readonly property real _minDuration: 5 * 60
    readonly property real _maxDuration: 10 * 60
    property real _delta: 0.0
    property real _duration: _minDuration + _delta
    property int _elapsedTime: 0

    id: root
    onPercentChanged: {
        root._delta = (root._maxDuration - root._minDuration) * root.percent;
        root._setDuration();
        progress = 0.0;
    }
    font.pixelSize: SH.dp(80)
    text: "05:00"

    Timer {
        id: timer
        interval: 1000
        repeat: !root.finished
        onTriggered: {
            root._elapsedTime++;
            root._updateRemainingTime();
            root.progress = root._elapsedTime / root._duration;
            if (root._elapsedTime >= root._duration) {
                root.finished = true;
            }
        }
    }

    // ----- Public Functions ----- //

    function startTimer() {
        if (timer.running === false) {
            timer.start();
        }
    }

    function stopTimer() {
        timer.stop();
        root.progress = 0;
        root.text = "05:00";
        root._elapsedTime = 0;
    }

    // ----- Private Functions ----- //

    function _updateRemainingTime() {
        var duration = root._duration - root._elapsedTime;
        var minutes = parseInt(duration / 60.0);
        var remaining = duration - minutes * 60;
        var seconds = parseInt(remaining) < 10 ? "0" + parseInt(remaining) : parseInt(remaining);

        if (minutes > 9) {
            root.text = minutes + ":" + seconds;
        }
        else {
            root.text = "0" + minutes + ":" + seconds;
        }
    }

    function _setDuration() {
        var delta = Math.ceil(_delta);
        if (root.percent === 1) {
            delta = 300;
        }
        else if (root.percent === 0) {
            delta = 0;
        }

        root._duration = _minDuration + delta;
        var minutes = parseInt(_duration / 60.0);
        var remaining = Math.floor(delta % 60);
        var seconds = parseInt(remaining) < 10 ? "0" + parseInt(remaining) : parseInt(remaining);

        if (minutes > 9) {
            root.text = minutes + ":" + seconds;
        }
        else {
            root.text = "0" + minutes + ":" + seconds;
        }
    }
}
