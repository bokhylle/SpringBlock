#include <QPainter>
#include <QDebug>
#include "spring.h"
#include "node.h"
#include <iostream>
#include <cmath>
#include <QCursor>
#include <algorithm>
#include <chrono>
using namespace std;

Spring::Spring(QQuickItem *parent): QQuickPaintedItem(parent)
{

}

void Spring::paint(QPainter *painter){

//    auto t0 = std::chrono::high_resolution_clock::now();
    double x1,y1,x2,y2;
    QColor color;
    x1 = 0; y1 = 0; x2 = 50; y2 = 50;

    if(m_connection1 && m_connection2){
        x2 = m_connection2->x() - m_connection1->x();
        y2 = m_connection2->y() - m_connection1->y();
        color = m_colorAttached;
        setX(m_connection1->x());
        setY(m_connection1->y());

    }else if(m_connection1==nullptr && m_connection2==nullptr){
        color = m_colorDetached;
//        setX(m_initialX);
//        setY(m_initialY);
    }else if(m_connection1==nullptr){
        color = m_colorDetached;
        setX(m_connection2->x());
        setY(m_connection2->y());
    }else{
        color = m_colorDetached;
        setX(m_connection1->x());
        setY(m_connection1->y());
    }

    double angle = (atan2(y2,x2)/(M_PI)*180);
    double L = sqrt(x2*x2 + y2*y2);
    setWidth(L);
    setHeight(m_linewidth);
    double centerX = L/2*cos(angle*M_PI/180) - L/2;
    double centerY = L/2*sin(angle*M_PI/180) - m_linewidth/2;
    setX(x()+centerX);
    setY(y()+centerY);
    setRotation(angle);
    QPen pen(color, m_linewidth);
    painter->setPen(pen);
    painter->setRenderHints(QPainter::Antialiasing, true);
    painter->drawLine(0, 0, L, 0);

//    auto t1 = std::chrono::high_resolution_clock::now();
//    auto dt = 1.e-6*std::chrono::duration_cast<std::chrono::nanoseconds>(t1-t0).count();
//    cout << "Spring redraw in "<< dt <<" ms."<< endl;

    //        setWidth(max(x1,x2) + 2*m_linewidth);
    //        setHeight(max(y1,y2) + 2*m_linewidth);
    //        QPen pen(color, m_linewidth);
    //        painter->setPen(pen);
    //        painter->setRenderHints(QPainter::Antialiasing, true);
    //        painter->drawLine(x1,y1,x2,y2);
}

Node *Spring::connection1() const
{
    return m_connection1;
}

Node *Spring::connection2() const
{
    return m_connection2;
}

void Spring::setConnection1(Node *connection1)
{
    if(m_connection1) {
        disconnect(m_connection1, SIGNAL(xChanged()), this, SLOT(update()));
        disconnect(m_connection1, SIGNAL(yChanged()), this, SLOT(update()));
    }
    m_connection1 = connection1;
    connect(connection1, SIGNAL(xChanged()), this, SLOT(update()));
    connect(connection1, SIGNAL(yChanged()), this, SLOT(update()));
    emit connection1Changed(connection1);
}

void Spring::setConnection2(Node *connection2)
{
    if(m_connection2) {
        disconnect(m_connection2, SIGNAL(xChanged()), this, SLOT(update()));
        disconnect(m_connection2, SIGNAL(yChanged()), this, SLOT(update()));
    }
    m_connection2 = connection2;
    connect(connection2, SIGNAL(xChanged()), this, SLOT(update()));
    connect(connection2, SIGNAL(yChanged()), this, SLOT(update()));
    emit connection2Changed(connection2);
}
