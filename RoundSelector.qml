import QtQuick 2.15
import QtCharts 2.15

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
            onHovered: {
                slice.exploded = state
            }
        }
    }

    onSectorCountChanged: {
        pieSeriesId.clear()
        for (let i = 0; i < sectorCount; i++) {
            pieSeriesId.append("", 100 / sectorCount)
        }
    }
}
