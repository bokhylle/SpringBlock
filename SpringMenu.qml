import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3


ListView {
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        topMargin: 10
        leftMargin: 10
    }
    width: 250

    model: selectedSpring
    delegate: Column {
        Row{
            Label{
                text: "Spring options"
                font.bold: true
            }
        }

        Row {
            Label {
                text: "ID parent 1: "
            }
            Label {
                height: 20
                //text: ""+root.selectedSpring.connection1.borderWidth.toFixed(0)
            }
        }

        Row {
            Label {
                text: "ID parent 2: "
            }
            Label {
                height: 20
                text: "lol"
            }
        }

        Row {
            Button{
                width: 200
                Text {
                    id: setSpringParents_buttontext
                    anchors.centerIn: parent.center
                    text: "Set parents"
                    color: "black"
                }
                onClicked: {
                    root.mode = "selectSpringParent1";
                    writemessage("Select spring parent 1")
                    if(selectedSpring.connection1!==null){
                        selectedSpring.connection1.removeSpring(selectedSpring)
                        selectedSpring.connection2.removeSpring(selectedSpring)
                    }
                    selectedSpring.connection1 = null
                    selectedSpring.connection2 = null
                    selectedSpring.update()
                }
            }
        }
    }
}
