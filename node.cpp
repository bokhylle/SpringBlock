#include <QPainter>
#include <QDebug>
#include <algorithm>
#include <vector>
#include "node.h"
#include "spring.h"

Node::Node(QQuickItem *parent): QQuickPaintedItem(parent)
{

}

Node::~Node(){

}

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
