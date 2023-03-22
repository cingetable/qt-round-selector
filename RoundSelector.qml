import QtQuick 2.15
import QtCharts 2.15
import "main.js" as Helper
Item {
    property int sectorCount: 20
    property real holeValue: 0.4

    ChartView {

        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        PieSeries {
            id: pieSeriesId
            holeSize: holeValue
        }
    }

    onSectorCountChanged: {
        pieSeriesId.clear()
        for (let i = 0; i < sectorCount; i++) {
            pieSeriesId.append("", 100 / sectorCount)
        }
    }

    MouseArea {
        anchors.fill: parent

        onPositionChanged: {
            let sectorNumber = Helper.getSectorNumber(parent.width / 2, parent.height / 2, mouse.x, mouse.y, pieSeriesId.count)
            for (var i = 0; i < pieSeriesId.count; i++) {
                if (containsPress) {
                    pieSeriesId.at(i).exploded = sectorNumber === i
                }
            }
        }

        onReleased: {
            for (var i = 0; i < pieSeriesId.count; i++) {
                    pieSeriesId.at(i).exploded = false
            }
        }
    }

}
