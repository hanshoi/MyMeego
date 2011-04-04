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
#include "mmdata.h"
#include "eventhandler.h"
#include <QDebug>

MMData::MMData(QObject *parent) :
    QObject(parent),
    m_isRequest(true),
    m_type(""),
    m_value(""),
    m_deviceId(""),
    m_events(1),
    m_currentevent(1)
{
}

bool MMData::isRequest()
{
    return m_isRequest;
}

void MMData::setIsRequest(bool isRequest)
{
    m_isRequest = isRequest;
}

QString MMData::type()
{
    return m_type;
}

void MMData::setType(const QString& type)
{
    m_type = type;
}

QString MMData::deviceId()
{
    return m_deviceId;
}

void MMData::setDeviceId(QString deviceId)
{
    m_deviceId = deviceId;
}

QString MMData::value()
{
    return m_value;
}

void MMData::setValue(const QString& value)
{
    m_value = value;
    emit valueChanged();
}

void MMData::setEvents(int events)
{
    m_currentevent = 1;
    m_events = events;
}

bool MMData::lastEvent()
{
    if(m_currentevent>=m_events)
    {
        qDebug() << "END";
        return true;
    }
    else
    {
        qDebug() << "NOT END";
        return false;
    }
}

void MMData::nextEvent()
{
    m_currentevent++;
}

void MMData::transferData()
{ 
    EventHandler::instance()->sendEvent(this);
}
