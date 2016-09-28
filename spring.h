#ifndef SPRING_H
#define SPRING_H
#include <vector>
#include <memory>
#include <QColor>
#include <QQuickPaintedItem>
#include "node.h"
#include <iostream>
using namespace std;

class Spring : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(class Node* connection1 READ connection1 WRITE setConnection1 NOTIFY connection1Changed)
    Q_PROPERTY(class Node* connection2 READ connection2 WRITE setConnection2 NOTIFY connection2Changed)
public:
    explicit Spring(QQuickItem *parent = 0);
    void paint(QPainter *painter);

    class Node* connection1() const;
    class Node* connection2() const;

    Q_INVOKABLE void setConnection1(class Node* connection1);
    Q_INVOKABLE void setConnection2(class Node* connection2);

public slots:


signals:
    void connection1Changed(class Node* connection1);
    void connection2Changed(class Node* connection2);

private:
    class Node* m_connection1 = nullptr;
    class Node* m_connection2 = nullptr;
    QColor m_colorAttached = "black";
    QColor m_colorDetached = "blue";
    double m_linewidth = 3;
    int m_initialX = 100;
    int m_initialY = 100;

};

#endif // SPRING_H
