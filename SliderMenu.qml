import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Window{

    property var fontSizeText: 16
    property var fontSizeInput: 14

    property var nx
    property var ny

    title: "Initialize slider"
    width: 300
    height: 300
    visible: false
    function open(){
        visible = true
    }
    function close(){
        visible = false
    }

    //Nx
    Item{
        id: setNx
        anchors.top: parent.top
        height: 25
        Text{
            id: nx_text
            width: 100
            font.pixelSize: fontSizeText
            text: "Nx: "
        }
        TextField{
            font.pixelSize: fontSizeInput
            id: nx_input
            width: 100
            anchors.left: nx_text.right
            onTextChanged:{
                nx = parseInt(text,0)
            }
        }
        Text{
            id: nx_units
            font.pixelSize: fontSizeText
            anchors.left: nx_input.right
            text: "[]"
        }
    }

    //Ny
    Item{
        id: setNy
        anchors.top: setNx.bottom
        height: 25
        Text{
            id: ny_text
            width: 100
            font.pixelSize: fontSizeText
            text: "Ny: "
        }
        TextField{
            font.pixelSize: fontSizeInput
            id: ny_input
            width: 100
            height: 25
            anchors.left: ny_text.right
            onTextChanged:{
                ny = parseInt(text,0)
            }
        }
        Text{
            id: ny_units
            font.pixelSize: fontSizeText
            anchors.left: ny_input.right
            text: "[]"
        }
    }

    //Initialize
    Item{
        anchors.top: setNy.bottom
        Button{
            text: "Create slider"
            onClicked: {

                var dx = 15
                var dy = 15
                var x0 = 150
                var y0 = 0

                //Set up nodes
                var nodelist = new Array(nx*ny)
                for(var ix = 0; ix<nx; ix++){
                    for(var iy = 0; iy<ny; iy++){
                        var component = Qt.createComponent("QNode.qml");
                        var node = component.createObject(root,{"x": (ix+1)*dx + x0, "y": (iy+1)*dy + y0})
                        var ind = ix + nx*iy
                        nodelist[ind] = node
                        if (node == null) {// Error Handling
                            console.log("Error creating object")
                            return
                        }
                        system.addQNode(node)
                    }
                }

                if(true){
                    //Set up springs
                    //Vertical:
                    for(var ix = 0; ix<nx; ix++){
                        for(var iy = 0; iy<ny-1; iy++){
                            var component = Qt.createComponent("QSpring.qml");
                            var spring = component.createObject(root)
                            if (spring == null) {// Error Handling
                                console.log("Error creating object")
                                return
                            }
                            system.addQSpring(spring)
                            //Connect to nodes:
                            var ind = ix + nx*iy
                            spring.connection1 = nodelist[ind]
                            spring.connection2 = nodelist[ind+nx]
                            spring.connection1.addSpring(selectedSpring)
                            spring.connection2.addSpring(selectedSpring)
                        }
                    }

                    //Horizontal:
                    for(var ix = 0; ix<nx-1; ix++){
                        for(var iy = 0; iy<ny; iy++){
                            var component = Qt.createComponent("QSpring.qml");
                            var spring = component.createObject(root)
                            if (spring == null) {// Error Handling
                                console.log("Error creating object")
                                return
                            }
                            system.addQSpring(spring)
                            var ind = ix + nx*iy
                            //Connect to nodes:
                            spring.connection1 = nodelist[ind]
                            spring.connection2 = nodelist[ind+1]
                            spring.connection1.addSpring(selectedSpring)
                            spring.connection2.addSpring(selectedSpring)
                        }
                    }

                    //Diagonal 1:
                    for(var ix = 0; ix<nx-1; ix++){
                        for(var iy = 0; iy<ny-1; iy++){
                            var component = Qt.createComponent("QSpring.qml");
                            var spring = component.createObject(root)
                            if (spring == null) {// Error Handling
                                console.log("Error creating object")
                                return
                            }
                            system.addQSpring(spring)
                            var ind = ix + nx*iy
                            //Connect to nodes:
                            spring.connection1 = nodelist[ind]
                            spring.connection2 = nodelist[ind+nx+1]
                            spring.connection1.addSpring(selectedSpring)
                            spring.connection2.addSpring(selectedSpring)
                        }
                    }

                    //Diagonal 2:
                    for(var ix = 1; ix<nx; ix++){
                        for(var iy = 0; iy<ny-1; iy++){
                            var component = Qt.createComponent("QSpring.qml");
                            var spring = component.createObject(root)
                            if (spring == null) {// Error Handling
                                console.log("Error creating object")
                                return
                            }
                            system.addQSpring(spring)
                            var ind = ix + nx*iy
                            //Connect to nodes:
                            spring.connection1 = nodelist[ind]
                            spring.connection2 = nodelist[ind+nx-1]
                            spring.connection1.addSpring(selectedSpring)
                            spring.connection2.addSpring(selectedSpring)
                        }
                    }
                }
                delete nodelist
                close()
            }
        }
    }
}
