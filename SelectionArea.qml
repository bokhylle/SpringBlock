import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.1





    MouseArea {


        Rectangle {
                id: selectionRect
                visible: false
                x: 0
                y: 0
                z: 99
                width: 0
                height: 0
                rotation: 0
                color: "#5F227CEB"
                border.width: 1
                border.color: "#103A6E"
                transformOrigin: Item.TopLeft
            }

        id: selectionMouseArea
        property int initialXPos
        property int initialYPos
        property bool justStarted

        anchors.fill: parent
        z: 10 // make sure we're above other elements
        onPressed: {
            if (mouse.button == Qt.LeftButton && mouse.modifiers & Qt.ShiftModifier)
            {
                console.log("Mouse area shift-clicked !")
                // initialize local variables to determine the selection orientation
                initialXPos = mouse.x
                initialYPos = mouse.y
                justStarted = true

//                flickableView.interactive = false // in case the event started over a Flickable element
                selectionRect.x = mouse.x
                selectionRect.y = mouse.y
                selectionRect.width = 0
                selectionRect.height = 0
                selectionRect.visible = true
            }
        }
        onPositionChanged: {
            if (selectionRect.visible == true)
            {
                if (justStarted == true && (mouse.x != initialXPos || mouse.y != initialYPos))
                {
                    if (mouse.x >= initialXPos)
                    {
                        if (mouse.y >= initialYPos)
                           selectionRect.rotation = 0
                        else
                           selectionRect.rotation = -90
                    }
                    else
                    {
                        if (mouse.y >= initialYPos)
                            selectionRect.rotation = 90
                        else
                            selectionRect.rotation = -180
                    }

                    justStarted = false
                    //console.log("Selection rotation: " + selectionRect.rotation)
                }

                if (selectionRect.rotation == 0 || selectionRect.rotation == -180)
                {
                    selectionRect.width = Math.abs(mouse.x - selectionRect.x)
                    selectionRect.height = Math.abs(mouse.y - selectionRect.y)
                }
                else
                {
                    selectionRect.width = Math.abs(mouse.y - selectionRect.y)
                    selectionRect.height = Math.abs(mouse.x - selectionRect.x)
                }
            }
        }

        onReleased: {
            selectionrectangle.visible = false
            //Set objects in selectionrectangle to selected
            //set selectionrectangle size to 0

        }
    }
