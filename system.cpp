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
    m_nodes.push_back(node);
    cout << "Added node number " << m_nodes.size() << " in cpp" << endl;
}

void System::addQSpring(Spring *spring)
{
    m_springs.push_back(spring);
    cout << "Added spring number " << m_springs.size() << " in cpp" <<  endl;

}
