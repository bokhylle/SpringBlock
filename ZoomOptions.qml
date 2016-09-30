import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.1

Rectangle{

    color: root.color
    Row{
        anchors.right: parent.right
        anchors.rightMargin: 10
        Rectangle{
            height: 25
            width: 25
            color: "white"
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: "+"
                font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    plotwindow.zoomIn()
                }
            }
        }

        Rectangle{
            height: 25
            width: 25
            color: "white"
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: "-"
                font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    plotwindow.zoomOut()
                }
            }
        }



        Rectangle{
            height: 25
            width: 25
            color: "white"
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: "L"
                font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    plotwindow.scrollLeft(10)
                }
            }
        }

        Rectangle{
            height: 25
            width: 25
            color: "white"
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: "R"
                font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    plotwindow.scrollRight(10)
                }
            }
        }


        Rectangle{
            height: 25
            width: 25
            color: "white"
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: "U"
                font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    plotwindow.scrollUp(10)
                }
            }
        }

        Rectangle{
            height: 25
            width: 25
            color: "white"
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: "D"
                font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    plotwindow.scrollDown(10)
                }
            }
        }

    }

}
