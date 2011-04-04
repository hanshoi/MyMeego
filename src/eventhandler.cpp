/*
 *  Copyright (c) 2011, Juhani Alanko, Marko Silokunnas, Juha Sinkkonen,
 *                      Antti Ruotsalainen, Rawdimension group
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation
 *     and/or other materials provided with the distribution.
 *  3. Neither the name of the Rawdimension Group nor the names
 *     of its contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *     AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 *     ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 *     LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *     POSSIBILITY OF SUCH DAMAGE.
 */
#include "eventhandler.h"
#include <QDBusPendingCall>
#include <QDebug>

#define DBUS_BACKEND_PATH "/org/mymeego/Backend"
#define DBUS_UI_PATH "/org/mymeego/Ui"
#define DBUS_BACKEND_NAME "org.mymeego.Backend"
#define DBUS_UI_NAME "org.mymeego.Ui"

EventHandler* EventHandler::handler = new EventHandler();

EventHandler::EventHandler(QObject *parent) :
    QObject(parent),
    m_backendInterface(0),
    m_agent(0),
    m_context(NULL)
{
}

EventHandler::~EventHandler()
{
    delete m_agent;
    m_agent = 0;
    delete m_backendInterface;
    m_backendInterface = 0;
    m_pendingEvents.clear();    // does not need to delete objects in it. qml owns them.
}

EventHandler* EventHandler::instance()
{
    return handler;
}

void EventHandler::init()
{
    // init backend interface
    if (m_backendInterface == 0)
    {
        QDBusConnection::sessionBus().registerService(DBUS_UI_NAME);
        m_backendInterface = new QDBusInterface(DBUS_BACKEND_NAME,DBUS_BACKEND_PATH,DBUS_BACKEND_NAME,QDBusConnection::sessionBus());

        qDebug() << "Dbus backend interface initialized";
    }

    // init agent
    if(m_agent == 0)
    {
        m_agent = new Agent(this);
        QDBusConnection::sessionBus().registerObject(DBUS_UI_PATH, this);
        connect(m_agent,SIGNAL(onEvent(QString,QString,QString)),this,SLOT(onIncomingEvent(QString,QString,QString)));

        qDebug() << "Agent initialized";
    }

}

void EventHandler::sendEvent(MMData* data)
{
    // try to init the event handler
    init();

    qDebug() << "Send event: " << data->type();

    // send event to dbus
    m_backendInterface->asyncCall(QLatin1String("transferData"),
                             qVariantFromValue((QString) data->deviceId()),
                             qVariantFromValue(QString(data->type())),
                             qVariantFromValue(QString(data->value())));

    // add event to pending list
    m_pendingEvents.push_back(data);


}

void EventHandler::onIncomingEvent(QString device, QString type, QString value)
{
    qDebug() << "Got an event: device: " << device << ", type: " << type << ", value: " << value;
    bool wasInPending = FALSE;


    // find compatible pending event
    foreach(MMData* data, m_pendingEvents)
    {
        // validate the parameters
        if(data->deviceId().compare(&device))
            continue;
        if(data->type() != type)
            continue;
        // params are equal
        // set value
        if(!value.isEmpty())
            data->setValue(value);
        // remove from pending
        if(data->lastEvent())
        {
            m_pendingEvents.removeOne(data);
        }
        data->nextEvent();
        wasInPending = TRUE;
    }

    // wasn't in pending list, possibly coming from backend
    if (!wasInPending)
    {
        // TODO: quick & dirty
        if (type == "DeviceListChanged")
        {
            m_context->updateDeviceList();
        }
        
    }

    qDebug() << "Event handled";
}
