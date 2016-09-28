import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Rectangle{
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }
    width: 250
    color: "white"
    border.color: "black"

    ListView {

        model: selectedNode

        delegate: Column {
            Row{
                Label{
                    text: "Block options"
                }
            }

            Row {

                Label {
                    text: "Mass"
                }
                TextField {
                    height: 20
                    text: model.modelData.mass
                    onTextChanged: {
                        model.modelData.mass = parseFloat(text)
                    }
                }
            }
            Row {
                Label {
                    text: "Position"
                }
                Label {
                    height: 20
                    text: "("+model.modelData.x.toFixed(0)+", "+model.modelData.y.toFixed(0)+")"
                }
            }
        }
    }
}
