import QtQuick 2.15
import QtQuick.Window 2.15
import QtCharts 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Round Selector")
    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        resizing: true

        Rectangle {
            width: 200
            Layout.maximumWidth: 400
            color: "beige"

            onWidthChanged: {
                sectorCountSliderId.width = width
            }

            Column {
                Label {
                    text: "Segment count"
                }
                Slider {
                    id: sectorCountSliderId
                    value: 4
                    minimumValue: 1
                    maximumValue: 6
                    stepSize: 1
                    wheelEnabled: true

                    onValueChanged: {
                        roundSelectorId.sectorCount = value
                    }
                }

                Label {
                    text: "Show Selector"
                }
                Button {
                    text: roundSelectorId.visible ? "Hide" : "Show"

                    onClicked: {
                        roundSelectorId.visible = !roundSelectorId.visible
                    }
                }

                Rectangle {
                    id: rectId
                    height: 100
                    width: parent.width
                }
            }
        }


        RoundSelector {
            id: roundSelectorId
            Layout.maximumWidth: 400

            target: rectId

            OpacityAnimator {
                target: roundSelectorId;
                from: 0;
                to: 1;
                duration: 500
                running: roundSelectorId.visible
            }

            OpacityAnimator {
                target: roundSelectorId;
                from: 1;
                to: 0;
                duration: 500
                running: !roundSelectorId.visible
            }
        }
    }
}
