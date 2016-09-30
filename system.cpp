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
            m_nodes[i]->setIsSelected(!m_nodes[i]->isSelected());
            if(m_nodes[i]->isSelected()){
                m_selectedNodes.push_back(m_nodes[i]);
            }else{
                m_selectedNodes.erase(remove(m_selectedNodes.begin(), m_selectedNodes.end(), m_nodes[i]), m_selectedNodes.end());
            }
        }
    }
    qDebug() << m_selectedNodes;
    emit selectedNodesChanged(m_selectedNodes);
}

void System::clearNodeSelection(){
    for(unsigned int i = 0; i<m_nodes.size(); i++){
            m_nodes[i]->setIsSelected(false);
    }
    m_selectedNodes.clear();
    emit selectedNodesChanged(m_selectedNodes);
}

void System::addNodeToSelection(Node* node){
    node->setIsSelected(true);
    m_selectedNodes.push_back(node);
    emit selectedNodesChanged(m_selectedNodes);
}

void System::removeNodeFromSelection(Node* node){
    node->setIsSelected(false);
    m_selectedNodes.erase(remove(m_selectedNodes.begin(), m_selectedNodes.end(), node), m_selectedNodes.end());
    emit selectedNodesChanged(m_selectedNodes);
}

void System::addAllNodesToSelection(){
    m_selectedNodes.clear();
    for(unsigned int i = 0; i<m_nodes.size(); i++){
        m_nodes[i]->setIsSelected(true);
        m_selectedNodes.push_back(m_nodes[i]);
    }
    emit selectedNodesChanged(m_selectedNodes);
}
