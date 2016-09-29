#include <QPainter>
#include <QDebug>
#include <algorithm>
#include <vector>
#include <QtCharts>
#include <QTransform>
#include <QRectF>
#include "node.h"
#include "spring.h"

Node::Node(QQuickItem *parent): QQuickPaintedItem(parent)
{

}

Node::~Node(){

}

//void Node::setAnchor(QPointF point){
//    m_anchor = point;
//}

void Node::paint(QPainter *painter){

    QColor borderColor = m_selected ? "gold" : m_borderColor;
    QPen pen(borderColor, m_borderWidth);
    painter->setPen(pen);
    painter->setBrush(m_color);
    painter->setRenderHints(QPainter::Antialiasing, true);
    painter->drawRoundedRect(0,0,width(),height(),0, 0);
}

void Node::addSpring(Spring* spring){
    m_springConnections.push_back(spring);
}

void Node::removeSpring(Spring* spring){
    m_springConnections.erase(remove(m_springConnections.begin(), m_springConnections.end(), spring), m_springConnections.end());
}

bool Node::isConnectedToNode(Node* node){

    for(unsigned int i = 0; i<m_springConnections.size(); i++){
        if(node == m_springConnections[i]->connection1() || node== m_springConnections[i]->connection2()){
            return true;
        }
    }
    return false;

}

void Node::setAnchor(QPointF point)
{
    m_anchor = point;
}
