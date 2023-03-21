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

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        resizing: true

        Rectangle {
            width: 200
            Layout.maximumWidth: 400
            color: "lightblue"

            onWidthChanged: {
                sectorCountSliderId.width = width
                holeSizeSliderId.width = width
            }

            Column {
                Label {
                    text: "Segment count"
                }
                Slider {
                    id: sectorCountSliderId
                    minimumValue: 1
                    maximumValue: 6
                    stepSize: 1
                    wheelEnabled: true

                    onValueChanged: {
                        roundSelectorId.sectorCount = value
                    }
                }

                Label {
                    text: "HoleSize"
                }
                Slider {
                    id: holeSizeSliderId
                    minimumValue: 0
                    maximumValue: 1
                    wheelEnabled: true

                    onValueChanged: {
                        roundSelectorId.holeValue = value
                    }
                }
            }
        }

        RoundSelector {
            id: roundSelectorId
            Layout.maximumWidth: 400

        }
    }
}
