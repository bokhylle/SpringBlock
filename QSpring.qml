import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import System 1.0
import Node 1.0
import Spring 1.0

Spring {

    id: spring
    height: 20
    width: 20
    z: 1

    MouseArea {
        id: dragArea
        onClicked: {
            if(root.mode==="selectSpringParent1" || root.mode==="selectSpringParent2") {

            }else{
                root.selectedNode = null;
                root.selectedSpring = spring;
            }
        }
        anchors.fill: parent
    }

    function setSpringParent(node) {
        if(mode === "selectSpringParent1") {
            selectedSpring.connection1 = node
            console.log("addingParent1")
            mode = "selectSpringParent2"
            writemessage("Select spring parent 2")
            selectedSpring.update()
        } else if(mode === "selectSpringParent2") {
            if(selectedSpring.connection1===node){
                console.log("parent selected twice, ignoring")
                mode = "selectSpringParent2"
                writemessage("A spring cannot be connected to the same node twice. Select spring parent 2")
            }else if(selectedSpring.connection1.isConnectedToNode(node)){
                console.log("connection already exists, ignoring")
                mode = "selectSpringParent2"
                writemessage("The nodes are already connected by a spring. Select spring parent 2")
            }else{
                mode = ""
                console.log("addingParent2")
                selectedSpring.connection2 = node
                connection1.addSpring(selectedSpring)
                connection2.addSpring(selectedSpring)
                writemessage("")
            }
            selectedSpring.update()
        }
    }

//    Timer {
//        id: springTimer
//        interval: 1
//        repeat: true
//        running: true
//        triggeredOnStart: true
//        onTriggered: update()
//    }

}
