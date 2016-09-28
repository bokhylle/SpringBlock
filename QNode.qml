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

    borderColor: "black"
    borderWidth: 2
    //anchors.centerIn: parent

    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0

    MouseArea {
        id: dragArea
        onClicked: {
            console.log(root.mode)
            if(root.mode==="selectSpringParent1" || root.mode==="selectSpringParent2") {
                root.selectedSpring.setSpringParent(node)
            } else {
                root.selectedSpring = null
                root.selectedNode = node
            }
        }

        anchors.fill: parent
        drag.target: parent
    }

}
