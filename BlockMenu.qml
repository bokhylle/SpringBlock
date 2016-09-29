import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

ListView {
    anchors.fill: parent
    anchors.leftMargin: 10
    anchors.topMargin: 10

    model: selectedNode
    delegate: Column {
        Row{
            Label{
                text: "Block options"
                font.bold: true
            }
            anchors.bottomMargin: 5
        }

        Row {
            Label {
                text: "Mass: "
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
}
