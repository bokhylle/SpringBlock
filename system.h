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
    Q_PROPERTY(QList<QObject*> selectedNodes MEMBER m_selectedNodes NOTIFY selectedNodesChanged)

public:
    System();
    Q_INVOKABLE void addQNode(class Node *node);
    Q_INVOKABLE void addQSpring(class Spring *spring);
    Q_INVOKABLE void setScreenCoordinatesFromLocalCoordinates(QPointF origoInScreenCoordinates, QPointF unitInScreenCoordinates);
    Q_INVOKABLE void setSelectedOnNodesInRectangle(double x0, double y0, double width, double height);
    Q_INVOKABLE void addAllNodesToSelection();
    Q_INVOKABLE void clearNodeSelection();
    Q_INVOKABLE void addNodeToSelection(class Node* node);
    Q_INVOKABLE void removeNodeFromSelection(class Node* node);

public slots:

signals:
    void selectedNodesChanged(QList<QObject*> selectedNodes);

private:
    vector<class Node*> m_nodes;
    vector<class Spring*> m_springs;
    vector<class ForceModifier*> m_forceModifiers;
    vector<class FrictionLaw*> m_frictionLaws;
    QList<QObject*> m_selectedNodes;
};

#endif // SYSTEM_H
