#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "node.h"
#include "system.h"
#include "spring.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<System>("System", 1, 0, "System");
    qmlRegisterType<Node>("Node", 1, 0, "Node");
    qmlRegisterType<Spring>("Spring", 1, 0, "Spring");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();

}
