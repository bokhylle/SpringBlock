import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.2
import System 1.0

ListView {
    id: listview

    property var selectedNodes: system.selectedNodes
    onSelectedNodesChanged:setMode()

    model: system.selectedNodes[0]
    property var mode

    function setMode(){
        if(system.selectedNodes.length===0){mode = "off"; height = 0}
        if(system.selectedNodes.length===1){mode = "single"; height = 100}
        if(system.selectedNodes.length>1){mode = "multiple"; height = 100}

        console.log(listview.contentHeight)
    }

    //Single menu
    delegate: Item{
        id:menu
        Column {
            visible: mode==="single"
            Row{
                Label{
                    text: "Node options:"
                    font.bold: true
                }
                anchors.bottomMargin: 5
            }
            Row {
                Label {
                    text: "ID: "
                }
                Label {
                    height: 20
                    text: model.modelData.nodeId.toFixed(0)
                }
            }
            Row {
                Label {
                    text: "mass: "
                }
                TextField {
                    height: 20
                    text: model.modelData.mass
                    onTextChanged: {
                        if(!isNaN(parseFloat(text))){
                            model.modelData.mass = parseFloat(text)
                        }
                    }
                }
            }
            Row {
                Label {
                    text: "x: "
                }
                Label {
                    height: 20
                    text: model.modelData.nodePosition.x.toFixed(2)
                }
            }
            Row {
                Label {
                    text: "y: "
                }
                Label {
                    height: 20
                    text: model.modelData.nodePosition.y.toFixed(2)
                }
            }
        }


        Column {
            visible: mode==="multiple"
            Row{
                Label{
                    text: "Node options:\n(multiple nodes selected)"
                    font.bold: true
                }
                anchors.bottomMargin: 5
            }


        }
    }

}
