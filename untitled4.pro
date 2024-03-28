QT += quick widgets quickcontrols2 statemachine webenginewidgets

#INCLUDEPATH = A:/Qt/xlnt_x64-windows/include
#LIBS += A:/Qt/xlnt_x64-windows/debug/lib/xlntd.lib

INCLUDEPATH = C:/Users/kznts/vcpkg/packages/xlnt_x64-windows/include
LIBS += C:/Users/kznts/vcpkg/packages/xlnt_x64-windows/debug/lib/xlntd.lib

CONFIG += qmltypes
QML_IMPORT_NAME = com.mycompany.qmlcomponents
QML_IMPORT_MAJOR_VERSION = 1

SOURCES += \
        main.cpp \
        readtable.cpp \
        tablemodel.cpp \
        webworker.cpp

resources.files = main.qml \
                  TableBuild.qml
resources.prefix = /$${TARGET}
RESOURCES += resources

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    includes.h \
    readtable.h \
    tablemodel.h \
    webworker.h

FORMS +=
