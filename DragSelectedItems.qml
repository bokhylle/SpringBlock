import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.1

MouseArea{
    id: mover
    anchors.fill: plotwindow
    acceptedButtons: Qt.RightButton
    drag.target: dragProxy
    propagateComposedEvents: true
    z: 1
    Rectangle{
        id: dragProxy
        x: 0
        y: 0
        width: 0
        height: 0
        property int lastX;
        property int lastY;
        onXChanged:
        {
            var deltaX = x - lastX;
            for(var i = 0; i < system.selectedNodes.length; ++i)
                system.selectedNodes[i].x += deltaX;
            lastX = x;
        }
        onYChanged:
        {
            var deltaY = y - lastY;
            for(var i = 0; i < system.selectedNodes.length; ++i)
                system.selectedNodes[i].y += deltaY;
            lastY = y;
        }
    }
}
