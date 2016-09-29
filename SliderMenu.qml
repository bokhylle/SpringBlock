import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Window{

    property var fontSizeText: 16
    property var fontSizeInput: 14

    property var x0
    property var y0
    property var nx
    property var ny
    property var lx
    property var ly
    property var mass

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

    //Lx
    Item{
        id: setLx
        anchors.top: setNy.bottom
        height: 25
        Text{
            id: lx_text
            width: 100
            font.pixelSize: fontSizeText
            text: "Lx: "
        }
        TextField{
            font.pixelSize: fontSizeInput
            id: lx_input
            width: 100
            height: 25
            anchors.left: lx_text.right
            onTextChanged:{
                lx = parseFloat(text,10)
            }
        }
        Text{
            id: lx_units
            font.pixelSize: fontSizeText
            anchors.left: lx_input.right
            text: "[m]"
        }
    }

    //Mass
    Item{
        id: setMass
        anchors.top: setLx.bottom
        height: 25
        Text{
            id: mass_text
            width: 100
            font.pixelSize: fontSizeText
            text: "Mass: "
        }
        TextField{
            font.pixelSize: fontSizeInput
            id: mass_input
            width: 100
            height: 25
            anchors.left: mass_text.right
            onTextChanged:{
                mass = parseFloat(text,10)
            }
        }
        Text{
            id: mass_units
            font.pixelSize: fontSizeText
            anchors.left: mass_input.right
            text: "[kg]"
        }
    }

    //x0
    Item{
        id: setX0
        anchors.top: setMass.bottom
        height: 25
        Text{
            id: x0_text
            width: 100
            font.pixelSize: fontSizeText
            text: "x0: "
        }
        TextField{
            font.pixelSize: fontSizeInput
            id: x0_input
            width: 100
            height: 25
            anchors.left: x0_text.right
            onTextChanged:{
                x0 = parseFloat(text,10)
            }
        }
        Text{
            id: x0_units
            font.pixelSize: fontSizeText
            anchors.left: x0_input.right
            text: "[m]"
        }
    }

    //y0
    Item{
        id: setY0
        anchors.top: setX0.bottom
        height: 25
        Text{
            id: y0_text
            width: 100
            font.pixelSize: fontSizeText
            text: "y0: "
        }
        TextField{
            font.pixelSize: fontSizeInput
            id: y0_input
            width: 100
            height: 25
            anchors.left: y0_text.right
            onTextChanged:{
                y0 = parseFloat(text,10)
            }
        }
        Text{
            id: y0_units
            font.pixelSize: fontSizeText
            anchors.left: y0_input.right
            text: "[m]"
        }
    }

    //Initialize
    Item{
        anchors.top: setY0.bottom
        Button{
            text: "Create slider"
            onClicked: {

                ly = ny/nx*lx
                var dx = lx/(nx-1)
                if(nx===1){
                    dx = 0
                }
                var dy = ly/(ny-1)
                if(ny===1){
                    dy = 0
                }
                var m = mass/(nx*ny)
                var origo = plotwindow.mapToPosition(Qt.point(0,0))
                var unit = plotwindow.mapToPosition(Qt.point(1.0,1.0))


                //Set up nodes
                var nodelist = new Array(nx*ny)
                for(var ix = 0; ix<nx; ix++){
                    for(var iy = 0; iy<ny; iy++){
                        var component = Qt.createComponent("QNode.qml");
                        var xLocalTmp = (ix)*dx + x0
                        var yLocalTmp = (iy)*dy + y0
                        var node = component.createObject(plotwindow,{"x": xLocalTmp*(unit.x-origo.x)+origo.x, "y": yLocalTmp*(unit.y-origo.y)+origo.y,"mass": m})
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
                            var spring = component.createObject(plotwindow)
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
                            var spring = component.createObject(plotwindow)
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
                            var spring = component.createObject(plotwindow)
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
                            var spring = component.createObject(plotwindow)
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
