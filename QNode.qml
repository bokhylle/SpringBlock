import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import System 1.0
import Node 1.0
import Spring 1.0


Node {

    id: node
    color: "gray"
    width: 10
    height: 10
    z: 2
    property var nodePosition: plotwindow.mapToValue(Qt.point(x,y))
    xLocal: nodePosition.x
    yLocal: nodePosition.y
    borderColor: "black"
    borderWidth: 2
    transform: Translate { x: -width/2; y: -width/2}

    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0

    MouseArea {
        id: dragArea
        onClicked: {
            console.log(x)
            if(root.mode==="selectSpringParent1" || root.mode==="selectSpringParent2") {
                root.selectedSpring.setSpringParent(node)
            } else {
                root.selectedSpring = null
                root.selectedNode = node
            }
        }

        anchors.fill: parent
        drag.target: parent
        drag.minimumX: 0
        drag.minimumY: 0
        drag.maximumX: plotwindow.width-node.width
        drag.maximumY: plotwindow.height-node.height
    }

    function windowHandler(){
        var tmp = plotwindow.mapToPosition(nodePosition)
        x = tmp.x
        y = tmp.y
    }

}
