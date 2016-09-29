import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.1

ChartView{

    property var windowRatio: 1
    property var yCursorOnClick

    theme: ChartView.ChartThemeBlueIcy
    antialiasing: true
    axes: [axisX, axisY]
    legend.visible: false
    onWidthChanged: {
        windowRatio = height/width
        windowHandler()
    }
    onHeightChanged:{
        windowRatio = height/width
        windowHandler()
    }
    Component.onCompleted: {
        windowRatio = height/width
        windowHandler()
    }

    function windowHandler(){
        var origo = mapToPosition(Qt.point(0,0))
        var unit = mapToPosition(Qt.point(1.0,1.0))
        system.setScreenCoordinatesFromLocalCoordinates(origo, unit)
    }

    ValueAxis {
        id: axisX
        min: -1
        max: 1
        tickCount: 11
        titleText: "x (m)"
        onMinChanged: plotwindow.windowHandler()
        onMaxChanged: plotwindow.windowHandler()
    }

    ValueAxis {
        id: axisY
        min: -1*windowRatio //TODO: fix zoom bug
        max: 1*windowRatio
        tickCount: 11
        titleText: "y (m)"
//        onMaxChanged: plotwindow.windowHandler()
//        onMinChanged: plotwindow.windowHandler()
    }

    AreaSeries{
        axisX: axisX
        axisY: axisY
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log(plotwindow.mapToValue(Qt.point(mouse.x,mouse.y)))
        }
    }


}
