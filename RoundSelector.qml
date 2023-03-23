import QtQuick 2.15
import QtCharts 2.15
import "main.js" as Helper
Rectangle {
    property int sectorCount: 20
    property real holeValue: 0.4

    property QtObject target: null

    property string baseColor: "grey"
    property string selectionColor: "green"

    ChartView {
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        animationDuration: 500
        animationOptions: ChartView.AllAnimations

        PieSeries {
            id: pieSeriesId
            holeSize: holeValue
        }
    }

    onSectorCountChanged: {

        pieSeriesId.clear()
        for (let i = 0; i < sectorCount; i++) {
            pieSeriesId.append("", 100 / sectorCount)
            var randomColor = '#' + Math.floor(Math.random()*16777215).toString(16);
            pieSeriesId.at(i).color = randomColor
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            let sectorNumber = Helper.getSectorNumber(parent.width / 2, parent.height / 2, mouse.x, mouse.y, pieSeriesId.count)
            for (var i = 0; i < pieSeriesId.count; i++) {
                pieSeriesId.at(i).exploded = sectorNumber === i
                var color = pieSeriesId.at(i).color
                pieSeriesId.at(i).color = pieSeriesId.at(i).exploded ? color : color
            }
        }

        onExited: {
            for (var i = 0; i < pieSeriesId.count; i++) {
                pieSeriesId.at(i).exploded = false
            }
        }

        onClicked: {
            let sectorNumber = Helper.getSectorNumber(parent.width / 2, parent.height / 2, mouse.x, mouse.y, pieSeriesId.count)
            target.color = pieSeriesId.at(sectorNumber).color
        }
    }

}
