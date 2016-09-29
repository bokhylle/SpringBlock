#include "system.h"
#include "node.h"
#include "spring.h"
#include <iostream>
#include <QDebug>
using namespace std;

System::System()
{

}

void System::addQNode(Node *node)
{
    node->setNodeId(m_nodes.size());
    m_nodes.push_back(node);
    cout << "Added node number " << m_nodes.size() << " in cpp" << endl;
}

void System::addQSpring(Spring *spring)
{
    m_springs.push_back(spring);
    cout << "Added spring number " << m_springs.size() << " in cpp" <<  endl;

}

void System::setScreenCoordinatesFromLocalCoordinates(QPointF origoInScreenCoordinates, QPointF unitInScreenCoordinates){

    for(unsigned int i = 0; i<m_nodes.size(); i++){

        double x = m_nodes[i]->xLocal()*(unitInScreenCoordinates.x()-origoInScreenCoordinates.x())+origoInScreenCoordinates.x();
        double y = m_nodes[i]->yLocal()*(unitInScreenCoordinates.y()-origoInScreenCoordinates.y())+origoInScreenCoordinates.y();
        m_nodes[i]->setX(x);
        m_nodes[i]->setY(y);
    }

}

void System::setSelectedOnNodesInRectangle(double x0, double y0, double width, double height){

    for(unsigned int i = 0; i<m_nodes.size(); i++){
        double x = m_nodes[i]->x();
        double y = m_nodes[i]->y();
        if(x>x0 && x<(x0+width) && y>y0 && y<(y0+height)){
            m_nodes[i]->setIsSelected(true);
            qDebug() << "set to true";
        }else{
            m_nodes[i]->setIsSelected(false);
            qDebug() << "set to false";
        }
    }

}
