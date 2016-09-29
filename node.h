#ifndef NODE_H
#define NODE_H
//#include <QObject>
#include <QDebug>
#include <QQuickPaintedItem>
#include <QColor>
#include <vector>
using namespace std;

class Node : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(double mass MEMBER m_mass NOTIFY massChanged)
    Q_PROPERTY(double borderWidth MEMBER m_borderWidth NOTIFY borderWidthChanged)
    Q_PROPERTY(QColor color MEMBER m_color NOTIFY colorChanged)
    Q_PROPERTY(QColor borderColor MEMBER m_borderColor NOTIFY borderColorChanged)
    Q_PROPERTY(double xLocal READ xLocal WRITE setXLocal NOTIFY xLocalChanged)
    Q_PROPERTY(double yLocal READ yLocal WRITE setYLocal NOTIFY yLocalChanged)
    Q_PROPERTY(bool isSelected READ isSelected WRITE setIsSelected NOTIFY isSelectedChanged)
    Q_PROPERTY(unsigned int nodeId READ nodeId WRITE setNodeId NOTIFY nodeIdChanged)

public:
    static int count;
    explicit Node(QQuickItem *parent = 0);
    ~Node();

    void paint(QPainter *painter);
    void setAnchor(QPointF point);
    bool selected() const;

    Q_INVOKABLE void removeSpring(class Spring* spring);
    Q_INVOKABLE void addSpring(class Spring* spring);
    Q_INVOKABLE bool isConnectedToNode(class Node* node);

    double xLocal() const { return m_xLocal; }
    double yLocal() const { return m_yLocal; }
    bool isSelected() const { return m_isSelected; }

    unsigned int nodeId() const
    {
        return m_nodeId;
    }

public slots:

    void setXLocal(double xLocal)
    {
        if (m_xLocal == xLocal)
            return;

        m_xLocal = xLocal;
        emit xLocalChanged(xLocal);
    }

    void setYLocal(double yLocal)
    {
        if (m_yLocal == yLocal)
            return;

        m_yLocal = yLocal;
        emit yLocalChanged(yLocal);
    }

    void setIsSelected(bool isSelected)
    {
        if (m_isSelected == isSelected)
            return;

        m_isSelected = isSelected;
        emit isSelectedChanged(isSelected);
    }

    void setNodeId(unsigned int nodeId)
    {
        if (m_nodeId == nodeId)
            return;

        m_nodeId = nodeId;
        emit nodeIdChanged(nodeId);
    }

signals:
    void massChanged(double mass);
    void borderColorChanged(QColor borderColor);
    void colorChanged(QColor color);
    void borderWidthChanged(double borderWidth);
    void xLocalChanged(double xLocal);
    void yLocalChanged(double yLocal);
    void isSelectedChanged(bool isSelected);

    void nodeIdChanged(unsigned int nodeId);

private:
    double m_mass;
    double m_borderWidth;
    QColor m_color;
    QColor m_borderColor;
    vector<class Spring *> m_springConnections;
    QPointF m_anchor;
    double m_xLocal;
    double m_yLocal;
    bool m_isSelected;
    unsigned int m_nodeId;
};

#endif // NODE_H
