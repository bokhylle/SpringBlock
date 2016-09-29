import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.1
import System 1.0
import Node 1.0
import Spring 1.0


ApplicationWindow {
    id: root
    property Node selectedNode
    property Spring selectedSpring
    property string mode: ""

    visible: true
    width: 1024
    height: 768
    minimumWidth: 480
    minimumHeight: 320

    title: qsTr("Spring block")

    System {
        id: system
    }

    Rectangle {
        id: createnode
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
            var node = component.createObject(plotwindow, {"x": (Math.random()-0.5)*100+plotwindow.width/2, "y": (Math.random()-0.5)*100+plotwindow.height/2})
            if (node == null) {
                // Error Handling
                console.log("Error creating object")
                return
            }
            system.addQNode(node)
        }

        MouseArea{
            anchors.fill: parent
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

            var spring = component.createObject(plotwindow ,{"x": (Math.random()-0.5)*100+plotwindow.width/2, "y": (Math.random()-0.5)*100+plotwindow.height/2})
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
            anchors.fill: parent
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
            anchors.fill: parent
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
            anchors.fill: parent
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
            text: "Clear disconnected \nsprings"
        }
        signal buttonClick()
        onButtonClick: {}
        MouseArea{
            anchors.fill: parent
            onClicked: parent.buttonClick()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }

    Rectangle{
        id:rightmenu
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        width: 150
        color: "lightblue"
        border.color: "black"
    }

    PlotWindow{
        id: plotwindow
        anchors.left: clearDisconnectedSprings.right
        anchors.right: rightmenu.left
        anchors.top: parent.top
        anchors.bottom: zoomoptions.top
    }


    MessageBox{
        id: messagebox
        messageboxVisible: false
    }

    SliderMenu{
        id: slidermenu
    }


    function writemessage(message){
        messagebox.text = message
        if(message!=""){
            messagebox.color = "red"
            messagebox.messageboxVisible = true
        }else{
            messagebox.color = "white"
            messagebox.messageboxVisible = false
        }
    }


    ZoomOptions{
        id: zoomoptions
        anchors {
            right: plotwindow.right
            bottom: parent.bottom
            left: plotwindow.left
        }
        height: 30
    }

    BlockMenu{
        id: blockmenu
        anchors.fill: rightmenu
    }

    SpringMenu{
        id: springmenu
        anchors.fill: rightmenu
    }

}
