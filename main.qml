import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import System 1.0
import Node 1.0
import Spring 1.0


ApplicationWindow {
    id: root
    property Node selectedNode
    property Spring selectedSpring
    property string mode: ""

    visible: true
    width: 640
    height: 480
    title: qsTr("Spring block")

    System {
        id: system
    }

    Rectangle {
        id: createNode
        width: 150; height: 75
        color: "lightblue"
        border.color: "black"

        Text{
            anchors.centerIn: parent
            text: "Create Node"
        }

        signal buttonClick()
        onButtonClick: {
            var component = Qt.createComponent("QNode.qml");
            var node = component.createObject(root, {"x": Math.random()*200, "y": Math.random()*200, "mass": 4})
            if (node == null) {
                // Error Handling
                console.log("Error creating object")
                return
            }
            system.addQNode(node)
        }

        MouseArea{
            anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
            onClicked: parent.buttonClick()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }


    Rectangle {
        id: createSpring
        width: 150; height: 75
        y: 75
        color: "lightblue"
        border.color: "black"
        Text{
            anchors.centerIn: parent
            text: "Create Spring"
        }
        signal buttonClick()
        onButtonClick: {
            var component = Qt.createComponent("QSpring.qml");
            var spring = component.createObject(root)
            if (spring == null) {
                // Error Handling
                console.log("Error creating object")
                return
            }
            root.selectedNode = null
            system.addQSpring(spring)
            root.selectedSpring = spring
            root.mode="selectSpringParent1"
            writemessage("Select spring parent 1")
        }

        MouseArea{
            anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
            onClicked: parent.buttonClick()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }

    }

    Rectangle {
        id: initializeSlider
        width: 150; height: 75
        y: 150
        color: "lightblue"
        border.color: "black"
        Text{
            anchors.centerIn: parent
            text: "Initialize slider"
        }
        signal buttonClick()
        onButtonClick: slidermenu.open()
        MouseArea{
            anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
            onClicked: parent.buttonClick()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }

    }

    Rectangle {
        id: clearSystem
        width: 150; height: 75
        y: 225
        color: "lightblue"
        border.color: "black"
        Text{
            anchors.centerIn: parent
            text: "Clear"
        }
        signal buttonClick()
        onButtonClick: {}
        MouseArea{
            anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
            onClicked: parent.buttonClick()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }



    Rectangle {
        id: clearDisconnectedSprings
        width: 150; height: 75
        y: 300
        color: "lightblue"
        border.color: "black"
        Text{
            anchors.centerIn: parent
            text: "Clear disconnected springs"
        }
        signal buttonClick()
        onButtonClick: {}
        MouseArea{
            anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
            onClicked: parent.buttonClick()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }

    BlockMenu{
        id: blockmenu
    }

    SpringMenu{
        id: springmenu
    }

    MessageBox{
        id: messagebox
    }

    SliderMenu{
        id: slidermenu
    }


    function writemessage(message){
        messagebox.text = message
        if(message!=""){
            messagebox.color = "red"
        }else{
            messagebox.color = "white"
        }
    }



}
