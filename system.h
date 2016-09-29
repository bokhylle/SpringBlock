#ifndef SYSTEM_H
#define SYSTEM_H
#include <vector>
#include <memory>
#include <QObject>
#include <QPointF>
using namespace std;

class System: public QObject
{
    Q_OBJECT
public:
    System();
    Q_INVOKABLE void addQNode(class Node *node);
    Q_INVOKABLE void addQSpring(class Spring *spring);
    Q_INVOKABLE void setScreenCoordinatesFromLocalCoordinates(QPointF origoInScreenCoordinates, QPointF unitInScreenCoordinates);

public slots:


private:
    vector<class Node*> m_nodes;
    vector<class Spring*> m_springs;
    vector<class ForceModifier*> m_forceModifiers;
    vector<class FrictionLaw*> m_frictionLaws;
};

#endif // SYSTEM_H
