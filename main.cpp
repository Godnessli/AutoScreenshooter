#include "includes.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QtWebEngineQuick::initialize();

    QQmlApplicationEngine engine;
    QQmlComponent *component = new QQmlComponent(&engine);
    component -> connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    component->loadUrl(QUrl("qrc:/untitled4/main.qml"));

    if (!component->isReady() ) {
        qWarning("%s", qPrintable(component->errorString()));
        return -1;
    }


    QObject *topLevel = component->create();
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    QSurfaceFormat surfaceFormat = window->requestedFormat();
    window->setFormat(surfaceFormat);
    window->show();

    delete component;
    return app.exec();
}
