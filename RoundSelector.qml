import QtQuick 2.15
import QtCharts 2.15
import "main.js" as Helper
Rectangle {
    property int sectorCount: 20
    property real holeValue: 0.4

    property QtObject target: null

    property string baseColor: "grey"
    property string selectionColor: "green"

    property var colors: new Array(6)

    color: "transparent"

    ChartView {
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        backgroundColor: "transparent"

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
            colors[i] = randomColor
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
                pieSeriesId.at(i).color = pieSeriesId.at(i).exploded ? Qt.darker(colors[i], 1.5) : colors[i]
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
