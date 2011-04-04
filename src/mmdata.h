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
#ifndef MMDATA_H
#define MMDATA_H

#include <QObject>

class MMData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isRequest READ isRequest WRITE setIsRequest)    // DEPRECATED
    Q_PROPERTY(QString type READ type WRITE setType)
    Q_PROPERTY(QString deviceId READ deviceId WRITE setDeviceId)
    Q_PROPERTY(QString value READ value WRITE setValue NOTIFY valueChanged)
public:
    explicit MMData(QObject *parent = 0);

    // is request
    bool isRequest();    // DEPRECATED
    void setIsRequest(bool isRequest);    // DEPRECATED

    // type
    QString type();
    void setType(const QString& type);

    // device id
    QString deviceId();
    void setDeviceId(QString deviceId);

    // value
    QString value();
    void setValue(const QString& value);

    // get data from backend
    Q_INVOKABLE void transferData();

    void setEvents(int events);

    bool lastEvent();

    void nextEvent();

signals:
    void valueChanged();
private:
    bool m_isRequest; //DEPRECATED
    int m_events;
    int m_currentevent;
    QString m_type;
    QString m_deviceId;
    QString m_value;
};

#endif // MMDATA_H
