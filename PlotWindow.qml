import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.1

ChartView{

    property var windowRatio: 1

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
        id: selectionarea
        property int initialXPos
        property int initialYPos
        onPressed: {
            if (mouse.button == Qt.LeftButton && mouse.modifiers & Qt.ShiftModifier)
            {
                console.log("Mouse area shift-clicked !")
                initialXPos = mouse.x
                initialYPos = mouse.y
                selectionrectangle.x = mouse.x
                selectionrectangle.y = mouse.y
                selectionrectangle.width = 0
                selectionrectangle.height = 0
                selectionrectangle.visible = true
            }
        }

        onPositionChanged: {
            if (selectionrectangle.visible == true)
            {
                if (mouse.x != initialXPos || mouse.y != initialYPos)
                {
                    if(mouse.x>=initialXPos && mouse.y>=initialYPos){
                        selectionrectangle.rotation = 0
                        selectionrectangle.xTopLeft = initialXPos
                        selectionrectangle.yTopLeft = initialYPos
                    }else if(mouse.x < initialXPos && mouse.y > initialYPos){
                        selectionrectangle.rotation = 90
                        selectionrectangle.xTopLeft = mouse.x
                        selectionrectangle.yTopLeft = initialYPos
                    }else if(mouse.x < initialXPos && mouse.y < initialYPos){
                        selectionrectangle.rotation = -180
                        selectionrectangle.xTopLeft = mouse.x
                        selectionrectangle.yTopLeft = mouse.y
                    }else if(mouse.x > initialXPos && mouse.y < initialYPos){
                        selectionrectangle.rotation = -90
                        selectionrectangle.xTopLeft = initialXPos
                        selectionrectangle.yTopLeft = mouse.y
                    }
                }
                if (selectionrectangle.rotation == 0 || selectionrectangle.rotation == -180){
                    selectionrectangle.width = Math.abs(mouse.x - selectionrectangle.x)
                    selectionrectangle.height = Math.abs(mouse.y - selectionrectangle.y)
                }
                else{
                    selectionrectangle.width = Math.abs(mouse.y - selectionrectangle.y)
                    selectionrectangle.height = Math.abs(mouse.x - selectionrectangle.x)
                }
            }
        }

        onReleased: {
            if(selectionrectangle.visible == true){
            selectionrectangle.visible = false
            //perform action on object in selection
            system.setSelectedOnNodesInRectangle(selectionrectangle.xTopLeft, selectionrectangle.yTopLeft, Math.abs(mouse.x - initialXPos), Math.abs(mouse.y - initialYPos))

            selectionrectangle.x = 0
            selectionrectangle.y = 0
            selectionrectangle.width = 0
            selectionrectangle.height = 0
            }

        }

    }

    Rectangle{
        id: selectionrectangle
        z:10
        visible: false
        property var xTopLeft
        property var yTopLeft
        x: 0
        y: 0
        width: 0
        height: 0
        rotation: 0
        color: "#5F227CEB"
        border.width: 1
        border.color: "#103A6E"
        transformOrigin: Item.TopLeft
    }


}
