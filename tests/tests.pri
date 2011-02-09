include (../qt-components.pri)

DEPENDPATH  += $$INCLUDEPATH .
CONFIG -= app_bundle
QT += declarative

TEMPLATE = lib ## this is a hack to make qtLibraryTarget return the correct value
INCLUDEPATH += \
    $$Q_COMPONENTS_SOURCE_TREE/src/components \
    $$Q_COMPONENTS_SOURCE_TREE/tests/shared
LIBS += -L$$Q_COMPONENTS_BUILD_TREE/imports/Qt/labs/components -l$$qtLibraryTarget(qtcomponentsplugin)
DEFINES += Q_COMPONENTS_BUILD_TREE=\"\\\"$${Q_COMPONENTS_BUILD_TREE}\\\"\"

# ### Don't know how to replicate this feature on non-Unix systems, the
# idea here is that the tests can run using the .so in the working directory,
# because the .so we are testing is not installed in a visible library directory
# on the system, because it is part of a QML module.
QMAKE_RPATHDIR = $$Q_COMPONENTS_BUILD_TREE/lib $$QMAKE_RPATHDIR
QMAKE_RPATHDIR = $$Q_COMPONENTS_BUILD_TREE/imports/Qt/labs/components $$QMAKE_RPATHDIR
