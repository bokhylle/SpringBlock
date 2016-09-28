#ifndef NODE_H
#define NODE_H
#include <QObject>
#include <QDebug>
#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <vector>
#include <memory>
using namespace std;

class Node : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(double mass MEMBER m_mass NOTIFY massChanged)
    Q_PROPERTY(double borderWidth MEMBER m_borderWidth NOTIFY borderWidthChanged)
    Q_PROPERTY(QColor color MEMBER m_color NOTIFY colorChanged)
    Q_PROPERTY(QColor borderColor MEMBER m_borderColor NOTIFY borderColorChanged)
public:
    //Node();
    static int count;
    Node(QQuickItem *parent = 0);
    ~Node();

    void paint(QPainter *painter);
    bool selected() const;

    Q_INVOKABLE void removeSpring(class Spring* spring);
    Q_INVOKABLE void addSpring(class Spring* spring);

public slots:

signals:
    void massChanged(double mass);
    void borderColorChanged(QColor borderColor);
    void colorChanged(QColor color);
    void borderWidthChanged(double borderWidth);

private:
    double m_mass;
    double m_borderWidth;
    QColor m_color;
    QColor m_borderColor;
    bool m_selected = false;
    vector<class Spring *> m_springConnections;
};

#endif // NODE_H
