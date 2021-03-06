import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3


Rectangle {
    id: box
    z: 3
    anchors {
        right: parent.right
        bottom: parent.bottom
        left: parent.left
    }
    height: 50
    color: "white"
    border.color: "black"
    property alias text: message.text
    property alias messageboxVisible: box.visible

    Text{
        id: message
        text: ""
        anchors.centerIn: parent
    }
}
