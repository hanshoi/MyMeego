#-------------------------------------------------
#
# Project created by QtCreator 2010-11-30T11:00:23
#
#-------------------------------------------------

QT       += core gui declarative dbus

TARGET = mymeego
TEMPLATE = app

MOC_DIR = ../tmp
OBJECTS_DIR = ../tmp

SOURCES += main.cpp\
        mainwindow.cpp \
    eventhandler.cpp \
    mmdata.cpp \
    agent.cpp \
    transferlist.cpp

HEADERS  += mainwindow.h \
    eventhandler.h \
    mmdata.h \
    agent.h \
    transferlist.h

FORMS    += mainwindow.ui

OTHER_FILES += \
# colibri
    lib/colibri/CLCarousel.qml \
    lib/colibri/CLListbox.qml \
    lib/colibri/includes/TestCoverList.qml \
    lib/colibri/CLTextArea.qml \
    lib/colibri/CLTab.qml \
    lib/colibri/CLStyle.qml \
    lib/colibri/CLSliderVertical.qml \
    lib/colibri/CLSlider.qml \
    lib/colibri/CLScrollBarVertical.qml \
    lib/colibri/CLScrollBar.qml \
    lib/colibri/CLRating.qml \
    lib/colibri/CLProgressBar.qml \
    lib/colibri/CLLineEdit.qml \
    lib/colibri/CLLayer.qml \
    lib/colibri/CLKeyboard.qml \
    lib/colibri/CLHistogram.qml \
    lib/colibri/CLDial.qml \
    lib/colibri/CLDatePicker.qml \
    lib/colibri/CLComboBox.qml \
    lib/colibri/CLCheckBox.qml \
    lib/colibri/CLButton.qml \
    lib/colibri/gradients/Red.qml \
    lib/colibri/gradients/LightBlue.qml \
    lib/colibri/gradients/Grey.qml \
    lib/colibri/gradients/Blue.qml \
    lib/colibri/javascripts/keyboard.js \
    lib/colibri/javascripts/histogram2.js \
    lib/colibri/javascripts/histogram.js \
    lib/colibri/javascripts/functions.js \
    lib/colibri/javascripts/datepicker.js \
    lib/colibri/javascripts/date.js \
#modified colibri files
    lib/CLCarousel.qml \
    lib/CLSlider.qml \
#own qml files
    qml/MusicTransfer.qml \
    qml/MainScreen.qml \
    qml/DeviceMenuBar.qml \
    qml/DeviceButton.qml \
    qml/Theme.qml \
    lib/CLSlider.qml \
    qml/DeviceMenuBarItem.qml \
    testdata.xml \
    qml/DeviceListModel.qml \
    lib/MovieView.qml \
    lib/MusicView.qml \
    lib/colibri/includes/TestMovieList.qml \
    qml/MovieTransfer.qml \
    qml/TransferView.qml \
    lib/colibri/includes/TestPictureList.qml \
    lib/PictureView.qml \
    qml/PictureTransfer.qml \
    qml/MVPButtons.qml \
    javascript/Windowing.js \
    qml/Dialog.qml \
    qml/TransferringDialog.qml

RCC_DIR += ../res
RESOURCES += \
    resources.qrc \
    ../res/imgres.qrc

target.path = /usr/bin
INSTALLS += target
